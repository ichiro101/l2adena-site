class GameAccountsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user_game_accounts = current_user.user_game_accounts
  end

  def new
    @game_account = GameAccount.new
  end

  def create
    @game_account = GameAccount.new
    @game_account.login = params[:game_account][:login]
    @game_account.plain_password = params[:game_account][:plain_password]

    if @game_account.save
      # associate the game account with the current user
      user_game_account = UserGameAccount.new
      user_game_account.user_id = current_user.id
      user_game_account.login = @game_account.login
      user_game_account.save

      flash[:notice] = "Your ingame account has been created"
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @game_account = GameAccount.find_by_login(params[:id])
    raise Exceptions::AccessDenied if @game_account.nil?
    game_account_belongs_to_owner(@game_account)
  end

  def update
    @game_account = GameAccount.find_by_login(params[:id])
    raise Exceptions::AccessDenied if @game_account.nil?
    game_account_belongs_to_owner(@game_account)

    @game_account.plain_password = params[:game_account][:plain_password]

    if @game_account.save
      flash[:notice] = "Password changed"
      redirect_to :action => 'index'
    else
      render('index')
    end
  end

  private

  # Raise AccessDenied exception if the game account provided
  # in the params do not belong to the currently logged in 
  # user
  def game_account_belongs_to_owner(game_account)
    users = game_account.user_game_accounts

    users.each do |user|
      return true if user.user_id == current_user.id
    end

    raise Exceptions::AccessDenied
  end
end
