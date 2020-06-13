class PostsController < ApplicationController
  Max_page_size = 3

  def index
    page_token = params.has_key?(:older) ? params[:older] : params[:newer]
    
    paginate(page_token)
  end

  def topic
    page_token = params.has_key?(:older) ? params[:older] : params[:newer]
    
    @topic = Topic.find_by(alias: params[:topic])
    paginate(page_token, @topic.id)

    render 'index'
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @topics = Topic.all() 
    @post = Post.find(params[:id])
  end

  def new
    @topics = Topic.all() 
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to '/posts/' + @post.id.to_s
    else  
      @topics = Topic.all()
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to '/posts/' + @post.id.to_s
    else  
      @topics = Topic.all()
      render 'edit'
    end
  end

  private
  def post_params
    params[:post][:topic_id] = params[:post][:topic]
    params.require(:post).permit(:title, :body, :topic_id)
  end

  def paginate(page_token, topic_id = nil)
    pagination = Services::Pagination.new(page_token, topic_id)

    if page_token.present?
      if params.has_key?(:newer)
        @posts = pagination.newer
      else 
        @posts = pagination.older
      end  
    else 
      @posts = pagination.first_page
    end

    @has_newer = pagination.has_newer
    @has_older = pagination.has_older

    @page_token = pagination.construct_page_token
  end
end
