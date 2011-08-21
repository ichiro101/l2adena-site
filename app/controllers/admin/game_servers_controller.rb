class Admin::GameServersController < Admin::AdminController

  def index
    @game_servers = GameServer.all
  end

  def new
    @game_server = GameServer.new
    @game_server.gameserver_port = 7777
    @game_server.gameserver_database_port = 3306
  end

  def create
    @game_server = GameServer.new

    @game_server.name = params[:game_server][:name]
    @game_server.gameserver_hostname = params[:game_server][:gameserver_hostname]
    @game_server.gameserver_port = params[:game_server][:gameserver_port].to_i
    @game_server.gameserver_database_hostname = params[:game_server][:gameserver_database_hostname]
    @game_server.gameserver_database_port = params[:game_server][:gameserver_database_port].to_i
    @game_server.gameserver_database_username = params[:game_server][:gameserver_database_username]
    @game_server.gameserver_database_password = params[:game_server][:gameserver_database_password]
    @game_server.gameserver_database_name = params[:game_server][:gameserver_database_name]
    @game_server.visible = params[:game_server][:visible]

    if @game_server.save
      flash[:notice] = "Game server has been added"
      redirect_to admin_game_servers_path
    else
      render('admin/game_servers/new')
    end
  end

  def edit
    @game_server = GameServer.find(params[:id])
  end

  def update
    @game_server = GameServer.find(params[:id])

    @game_server.name = params[:game_server][:name]
    @game_server.gameserver_hostname = params[:game_server][:gameserver_hostname]
    @game_server.gameserver_port = params[:game_server][:gameserver_port].to_i
    @game_server.gameserver_database_hostname = params[:game_server][:gameserver_database_hostname]
    @game_server.gameserver_database_port = params[:game_server][:gameserver_database_port].to_i
    @game_server.gameserver_database_username = params[:game_server][:gameserver_database_username]
    @game_server.gameserver_database_password = params[:game_server][:gameserver_database_password]
    @game_server.gameserver_database_name = params[:game_server][:gameserver_database_name]
    @game_server.visible = params[:game_server][:visible]

    if @game_server.save
      flash[:notice] = "Game server information has been updated"
      redirect_to admin_game_servers_path
    else
      render('admin/game_servers/edit')
    end
  end

  def destroy
    game_server = GameServer.find(params[:id])
    game_server.destroy
    flash[:notice] = "Game server information has been removed"
    redirect_to admin_game_servers_path
  end

  def move_up
    @game_server = GameServer.find(params[:id])
    @game_server.move_higher
    redirect_to admin_game_servers_path
  end

  def move_down
    @game_server = GameServer.find(params[:id])
    @game_server.move_lower
    redirect_to admin_game_servers_path
  end

end
