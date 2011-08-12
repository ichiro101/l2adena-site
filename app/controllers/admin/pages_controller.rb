class Admin::PagesController < Admin::AdminController

  def index
    @pages = Page.order('position ASC').all
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
      redirect_to admin_page_path(@page)
    else
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])

    @page.name = params[:page][:name]
    @page.permalink = params[:page][:permalink]
    @page.content = params[:page][:content]
    @page.visible = params[:page][:visible]

    if @page.save
      flash[:success] = "The page has been updated"
      redirect_to admin_page_path(@page)
    else
      render('edit')
    end
  end

  def move_up
    @page = Page.find(params[:id])
    @page.move_higher
    redirect_to admin_pages_path
  end

  def move_down
    @page = Page.find(params[:id])
    @page.move_lower
    redirect_to admin_pages_path
  end

  def destroy
    page = Page.find(params[:id])
    page.delete
  end

end
