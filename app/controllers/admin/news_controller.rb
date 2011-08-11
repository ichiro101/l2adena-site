class Admin::NewsController < ApplicationController

  layout 'admin'

  def index
    @news_items = News.paginate(:page => params[:page])
  end

  def show
  end

  def new
    @news = News.new
  end

end
