class Admin::NewsController < Admin::AdminController

  def index
    @news_items = News.paginate(:page => params[:page]).order("created_at desc")
  end

  def show
    @news = News.find(params[:id])
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new

    @news.name = params[:news][:name]
    @news.user_id = current_user.id
    @news.content = params[:news][:content]

    if @news.save
      flash[:success] = "News has been posted"
      redirect_to admin_news_index_path
    else
      render('new')
    end
  end

  def edit
    @news = News.find(params[:id])
  end

  def update
    @news = News.find(params[:id])

    @news.name = params[:news][:name]
    @news.content = params[:news][:content]

    if @news.save
      flash[:success] = "News item has been updated"
      redirect_to admin_news_index_path
    else
      render('edit')
    end
  end

end
