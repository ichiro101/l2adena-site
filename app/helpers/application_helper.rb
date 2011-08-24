require 'socket'
require 'timeout'
module ApplicationHelper

  def error_messages_for(object)
    render(:partial => 'shared/error_messages_for', :locals => {:object => object})
  end

  # Renders the login server status and the game server status
  def server_status
    login_host = Rails.configuration.login_server_host
    login_port = Rails.configuration.login_server_port

    status_list = Array.new

    login_status = ServerStatus::ServerStatus.new
    login_status.name = "Login Server"

    begin
      timeout(0.5) do
        login_server_socket = TCPSocket.open(login_host, login_port)
        login_status.status = 1
      end
    rescue
      login_status.status = 0
    end

    status_list << login_status

    game_servers = GameServer.where(:visible => true).order("position ASC")

    game_servers.each do |game_server|
      status = ServerStatus::ServerStatus.new

      begin
        timeout(0.2) do 
          sock = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
          sockaddr = Socket.sockaddr_in(game_server.gameserver_port, game_server.gameserver_hostname)
          sock.connect(sockaddr)
          status.status = 1
        end
      rescue
        status.status = 0
      end

      # Set the name and the actual status of the game server
      status.name = game_server.name
      status_list << status
    end

    render(:partial => 'shared/server_status', :locals => {:status_list => status_list})
  end

end
