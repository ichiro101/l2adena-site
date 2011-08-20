class TicketsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @tickets = Ticket.all
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new
  end

end
