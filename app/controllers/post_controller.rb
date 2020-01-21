class PostController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
  
  end

  def new
    @post = Post.new
  end
  
  def create

  end

  private 

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_path # halts request cycle
    end
  end
end
