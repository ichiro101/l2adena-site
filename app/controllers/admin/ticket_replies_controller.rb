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
        @ticket_status_change = TicketStatusChange.new
        @ticket_status_change.status_change = params[:ticket][:status]
        @ticket_status_change.user = current_user
        @ticket_status_change.ticket = @ticket
        if @ticket_status_change.save
          @ticket_reply.ticket_status_change_id = @ticket_status_change.id
        else
          flash[:error] = "Something went wrong while changing the ticket status"
          render('admin/tickets/show')
          return
        end
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
