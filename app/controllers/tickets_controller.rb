class TicketsController < ApplicationController

  def index
    @tickets = Ticket.all
    @ticket = Ticket.new
  end

  def create

  end

end
