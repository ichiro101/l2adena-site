class Admin::TicketRepliesController < Admin::AdminController

  def create
    @ticket = Ticket.find(params[:id])
    @ticket_reply = TicketReply.new
    @ticket_reply.ticket = @ticket
    @ticket_reply.user = current_user
    @ticket_reply.content = params[:ticket_reply][:content]

    # save the status change first
    if(params[:status_changed])
      @ticket.status = params[:ticket][:status]
      unless @ticket.save
        # if something goes wrong, HALT rest of the operation and show the
        # form again
        flash[:error] = "Something went wrong while changing the ticket status"
        render('admin/tickets/show')
        return
      else
        flash[:notice] = "Ticket status has been changed"
      end
    end


    if @ticket_reply.save
      flash[:success] = "Ticket operation has been sucessful"
      redirect_to admin_ticket_path(@ticket)
    else
      render('admin/tickets/show')
    end
  end
end
