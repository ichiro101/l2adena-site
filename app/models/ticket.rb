class Ticket < ActiveRecord::Base
  belongs_to :user

  has_many :ticket_replies
  has_many :ticket_status_changes

  class TicketStatus
    attr_accessor :id
    attr_accessor :symbol
    attr_accessor :label
    attr_accessor :active

    def self.all
      all_ticket_status = Array.new

      resolved = TicketStatus.new
      resolved.id = 1
      resolved.symbol = :resolved
      resolved.label = "Resolved"
      resolved.active = false
      all_ticket_status << resolved

      invalid = TicketStatus.new
      invalid.id = 2
      invalid.symbol = :invalid
      invalid.active = false
      invalid.label = "Invalid"
      all_ticket_status << invalid

      more_info = TicketStatus.new
      more_info.id = 3
      more_info.symbol = :more_info
      more_info.active = true
      more_info.label = "More information is needed"
      all_ticket_status << more_info

      active = TicketStatus.new
      active.id = 4
      active.symbol = :active
      active.active = true
      active.label = "Active"
      all_ticket_status << active

      all_ticket_status
    end

    def self.find_by_symbol(symbol)
      all_items = TicketStatus.all
      all_items.each do |item|
        return item if item.symbol == symbol
      end
      nil
    end

    def self.find(id)
      all_items = TicketStatus.all
      all_items.each do |item|
        return item if item.id == id
      end
      nil
    end
  end

  def status_label
    status = Ticket::TicketStatus.find(self.status)
    raise StandardError if status.nil?
    status.label
  end

  validates_presence_of :name
  validates_presence_of :content
  validates_presence_of :status
  validates_presence_of :user_id

end
