class Admin::TicketsController < Admin::AdminController
  require 'rdiscount'

  def index
    @tickets = Ticket.paginate(:page => params[:page]).order("created_at desc")
  end

  def show
    @ticket = Ticket.find(params[:id])
    @ticket_replies = @ticket.ticket_replies
    @ticket_reply = TicketReply.new
  end
end
