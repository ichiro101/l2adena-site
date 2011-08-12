class Admin::PagesController < Admin::AdminController

  def index
    @pages = Page.all
  end

end
