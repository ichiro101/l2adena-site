class HomeController < ApplicationController

  def index
    @title = "L2Adena Home Page"
  end

  def show_page
    @page = Page.where(:permalink => params[:id]).first
  end

end
