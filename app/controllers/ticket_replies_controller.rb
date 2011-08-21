class TicketRepliesController < ApplicationController

  before_filter :authenticate_user!

  def create
    @ticket = Ticket.find(params[:id])
    object_belongs_to_user(@ticket)

    @ticket_reply = TicketReply.new
    @ticket_reply.ticket = @ticket
    @ticket_reply.user = current_user
    @ticket_reply.content = params[:ticket_reply][:content]

    if @ticket_reply.save
      flash[:notice] = "Your message has been posted to the ticket"
      redirect_to ticket_path(@ticket)
    else
      @ticket_replies = @ticket.ticket_replies
      render('tickets/show')
    end
  end

end
