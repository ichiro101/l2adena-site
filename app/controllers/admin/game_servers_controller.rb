class Admin::GameServersController < Admin::AdminController

  def index
    @game_servers = GameServer.all
  end

  def new
    @game_server = GameServer.new
  end

end
