class Ticket < ActiveRecord::Base

  class TicketStatus
    attr_accessor :id
    attr_accessor :symbol
  end

end
