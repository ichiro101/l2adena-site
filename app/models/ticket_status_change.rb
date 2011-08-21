class TicketStatusChange < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket

  validates_presence_of :user_id
  validates_presence_of :ticket_id
  validates_presence_of :status_change
end
