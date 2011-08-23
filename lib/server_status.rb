module ServerStatus
  class ServerStatus

    # The name will be used to label a server status
    attr_accessor :name

    # The status of #{:name}, 0 for offline, 1 for online
    attr_accessor :status
  end
end
