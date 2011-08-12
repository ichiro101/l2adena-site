class Admin::PagesController < Admin::AdminController

  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new

    # set the paramters from the form
    @page.name = params[:page][:name]
    @page.permalink = params[:page][:permalink]
    @page.content = params[:page][:content]
    @page.visible = params[:page][:visible]
    
    if @page.save
      flash[:success] = "The page has been created"
      redirect_to admin_pages_path
    else
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

end
