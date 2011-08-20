class Ticket < ActiveRecord::Base

  class TicketStatus
    attr_accessor :id
    attr_accessor :symbol
    attr_accessor :label

    def all
      all_ticket_status = Array.new

      resolved = Array.new
      resolved.id = 1
      resolved.symbol = :resolved
      resolved.label = "Resolved"
      all_ticket_status << resolved

    end
  end

end
