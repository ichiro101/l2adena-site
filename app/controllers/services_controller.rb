class ServicesController < ApplicationController

  before_filter :authenticate_user!, :except => [:create, :register, :signin, :signup, :newaccount, :failure]

  protect_from_forgery :except => :create # see https://github.com/intridea/omniauth/issues/203

  def index
    @services = current_user.services.order('provider asc')
  end

  # callback :success
  # This handles singing in and adding an authentication service to existing accounts itself
  # it renders a separate view if there is a new user to create
  def create

    # get the service parameter from the Rails router
    params[:service] ? service_route = params[:service] : service_route = "No service reconized (invalid callback)"

    omniauth = request.env['omniauth.auth']

    # continue only if hash and parameters exist
    if omniauth and params[:service]
      # Create a new hash
      @authhash = Hash.new

      if service_route == 'facebook'
        omniauth['extra']['user_hash']['email'] ? @authhash[:email] =  omniauth['extra']['user_hash']['email'] : @authhash[:email] = ''
        omniauth['extra']['user_hash']['name'] ? @authhash[:name] =  omniauth['extra']['user_hash']['name'] : @authhash[:name] = ''
        omniauth['extra']['user_hash']['id'] ?  @authhash[:uid] =  omniauth['extra']['user_hash']['id'].to_s : @authhash[:uid] = ''
        omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''
      elsif ['google', 'yahoo', 'twitter', 'myopenid', 'open_id'].index(service_route) != nil
        omniauth['user_info']['email'] ? @authhash[:email] =  omniauth['user_info']['email'] : @authhash[:email] = ''
        omniauth['user_info']['name'] ? @authhash[:name] =  omniauth['user_info']['name'] : @authhash[:name] = ''
        omniauth['uid'] ? @authhash[:uid] = omniauth['uid'].to_s : @authhash[:uid] = ''
        omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''
      else
        # Debug to output the hash that has been returned when adding new services
        render :text => omniauth.to_yaml
        return
      end

      if @authhash[:uid] != '' and @authhash[:provider] != ''
        auth = Service.find_by_provider_and_uid(@authhash[:provider], @authhash[:uid])

        # If the user is currently signed in, he/she might want to add another account to sign in
        if user_signed_in?
          if auth
            flash[:notice] = "Your account at " + @authhash[:provider].capitalize + " is already connected with this site."
            redirect_to services_path
          else
            current_user.services.create!(:provider => @authhash[:provider], :uid => @authhash[:uid], :uname => @authhash[:name], :uemail => @authhash[:email])
            flash[:notice] = 'Your ' + @authhash[:provider].capitalize + ' account has been added for signing in at this site.'
            redirect_to services_path
          end
        else
          if auth
            # signin existing user
            session[:user_id] = auth.user.id
            session[:service_id] = auth.id

            flash[:notice] = 'Signed in successfully via ' + @authhash[:provider].capitalize + '.'
            redirect_to root_url
          else
            # this is a new user; show signup; @authhash is available to the view and stored in the sesssion for creation of a new user
            session[:authhash] = @authhash
            redirect_to signup_services_path
          end
        end
      else
        flash[:error] = 'Error while authenticating via ' + service_route + '/' + @authhash[:provider].capitalize + '. The service returned invalid data for the user id.'
        redirect_to signin_path
      end
    else
      flash[:error] = 'Error while authenticating via ' + service_route.capitalize + '. The service did not return valid date.'
      redirect_to signin_apth
    end
  end

  def register
    @user = User.new
  end

  def newaccount
    if params[:commit] == "Cancel"
      session[:authhash] = nil
      session.delete :authhash
      redirect_to root_url
    else  # create account
      @newuser = User.new
      @newuser.username = params[:user][:username]
      @newuser.email = params[:user][:email]
      @newuser.password = ActiveSupport::SecureRandom.hex(30)

      if @newuser.save
        @newuser.services.create!(:provider => session[:authhash][:provider], :uid => session[:authhash][:uid], :uname => session[:authhash][:name], :uemail => session[:authhash][:email])
        # signin existing user
        # in the session his user id and the service id used for signing in is stored
        session[:user_id] = @newuser.id
        session[:service_id] = @newuser.services.first.id

        flash[:notice] = 'Your account has been created and you have been signed in!'
        redirect_to root_url
      else
        @authhash = session[:authhash]
        render('signup')
      end  
    end
  end

  def destroy
    # remove an authentication service linked to the current user
    @service = current_user.services.find(params[:id])

    if session[:service_id] == @service.id
      flash[:error] = 'You are currently signed in with this account!'
    else
      @service.destroy
    end

    redirect_to services_path
  end

  def signup
    @newuser = User.new
    @authhash = session[:authhash]
    @newuser.username = @authhash[:name]
    @newuser.email = @authhash[:email]
  end

  def signout
    if current_user
      session[:user_id] = nil
      session[:service_id] = nil
      session.delete :user_id
      session.delete :service_id
      flash[:notice] = 'You have been signed out!'
    end
    redirect_to root_url
  end

  def failure
    flash[:error] = 'There was an error at the remote authentication service. You have not been signed in.'
    redirect_to root_url
  end

end


