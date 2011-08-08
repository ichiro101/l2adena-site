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
end
