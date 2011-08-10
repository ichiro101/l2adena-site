module ServerStatus
  class ServerStatus

    # The name will be used to label a server status
    attr_accessor :name

    # The status of #{:name}, 0 for offline, 1 for online
    attr_accessor :status

    def status_string
      if self.status
        "<span class=\"online\">Online</span>"
      else
        "<span class=\"offline\">Offline</span>"
      end
    end

  end
end
