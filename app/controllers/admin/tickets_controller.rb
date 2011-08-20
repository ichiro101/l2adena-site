class Admin::TicketsController < Admin::AdminController

  def index
    @tickets = Ticket.paginate(:page => params[:page]).order("created_at desc")
  end

  def show
    @ticket = Ticket.find(params[:id])
  end
end
