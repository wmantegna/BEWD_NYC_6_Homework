class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comment = Comment.create(comment_params)
		@post.comments << @comment

		redirect_to post_path @post, notice: 'Comment created!'
	end

	private
	def comment_params
		params.require(:comment).permit(:content, :email, :post_id)
	end
end