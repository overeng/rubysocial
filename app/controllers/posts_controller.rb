class PostsController < ApplicationController
  def index
    @posts = Post.all()
  end

  def topic
    @topic = Topic.find_by(alias: params[:topic])
    @posts = @topic.posts
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
end
