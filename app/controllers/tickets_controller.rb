class TicketsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @tickets = Ticket.where(:user_id => current_user.id)
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new

    @ticket.user_id = current_user.id
    @ticket.status = Ticket::TicketStatus.find_by_symbol(:active).id
    @ticket.name = params[:ticket][:name]
    @ticket.content = params[:ticket][:content]

    if @ticket.save
      flash[:notice] = "Your ticket has been submitted, we will take a look at your ticket shortly, you may check the status of your ticket in the support page in
      the future"
      redirect_to tickets_path
    else
      @tickets = Ticket.where(:user_id => current_user.id)
      render('index')
    end
  end

  def show
    @ticket = Ticket.find(params[:id])

    object_belongs_to_user(@ticket)

    @ticket_replies = @ticket.ticket_replies
    @ticket_reply = TicketReply.new
  end

end
