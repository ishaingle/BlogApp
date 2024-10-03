class CommentsController < ApplicationController
	load_and_authorize_resource :post
	load_and_authorize_resource :comment, through: :post
	before_action :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(comment_params.merge(user: current_user))
		if @comment.save
			redirect_to @post, alert: "Successfully added a comment"
		else
			redirect_to @post, alert: "Failed to add comment"
		end
	end

	def destroy
		byebug
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		if @comment.user == current_user
			@comment.destroy
			redirect_to @post, notice: "Comment Successfully deleted"
		else
			redirect_to @post, notice: "You are not authorised to delete this comment"
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
