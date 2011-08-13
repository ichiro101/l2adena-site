class HomeController < ApplicationController

  def index
    @title = "L2Adena Home Page"
    @news_items = News.paginate(:page => params[:page]).order("created_at DESC")
  end

  def show_page
    @page = Page.where(:permalink => params[:id], :visible => true).first
  end

end
