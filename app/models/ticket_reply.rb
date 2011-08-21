class TicketReply < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket

  attr_accessor :new_status
  attr_accessor :status_changed

  validates_presence_of :user_id
  validates_presence_of :ticket_id
  validates_presence_of :content
end
