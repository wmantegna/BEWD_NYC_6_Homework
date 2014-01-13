class PostsController < ApplicationController
  def index
  	@posts = Post.all
  end

  def show
  	@post = Post.find(params[:id])
    
    @comment = Comment.new
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.create(post_params)
  	
  	redirect_to "/posts/#{@post.id}"
  end

  def edit
  	@post = Post.find(params[:id])
  end

  def update
  	@post = Post.find(params[:id])
  	@post.update_attributes(post_params)

  	redirect_to "/posts/#{@post.id}"
  end

  def destroy
  	@post = Post.find(params[:id])

    @post.comments.each do |c|
      c.destroy
    end
  	@post.destroy

  	redirect_to root_path
  end

  private
  def post_params
  	params.require(:post).permit(:title, :content)
  end
end