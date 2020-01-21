class PostController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @user = User.find_by(params[:id])
  end

  def new
    @user = User.find_by(params[:id])
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post created"
      redirect_to user_post_index_path
    else
      render 'new'
    end
  end

  private 

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_path # halts request cycle
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
