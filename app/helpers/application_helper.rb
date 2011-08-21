require 'socket'
module ApplicationHelper

  def error_messages_for(object)
    render(:partial => 'shared/error_messages_for', :locals => {:object => object})
  end

  # Renders the login server status and the game server status
  def server_status
    login_host = Rails.configuration.login_server_host
    login_port = Rails.configuration.login_server_port
    login_server_socket = TCPSocket.open(login_host, login_port)

    login_status = ServerStatus::ServerStatus.new
    login_status.name = "Login Server"
    if login_server_socket
      login_status.status = 1
    else
      login_status.status = 0
    end

    status_list = Array.new
    status_list << login_status

    game_servers = GameServer.where(:visible => true).order("position ASC")

    game_servers.each do |game_server|
      status = ServerStatus::ServerStatus.new
      
      socket = TCPSocket.open(game_server.gameserver_hostname, game_server.gameserver_port)

      # Set the name and the actual status of the game server
      status.name = game_server.name
      socket ? status.status = 1 : status.status = 0
      status_list << status
    end

    render(:partial => 'shared/server_status', :locals => {:status_list => status_list})
  end

end
