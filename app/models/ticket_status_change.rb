class TicketStatusChange < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket
  
  has_one :ticket_reply

  validates_presence_of :user_id
  validates_presence_of :ticket_id
  validates_presence_of :status_change

  def status_change_label
    id = self.status_change
    item = Ticket::TicketStatus.find(id)
    raise StandardError if item.nil?
    item.label
  end

end
