class CommentsController < ApplicationController
    def create
        @comment = Comment.new(params.permit(:body, :post_id, :parent_id))
        unless params[:parent_id].present?
            @comment.parent_id = 0
        end
        @comment.save
        render :json => { comment: @comment, errors: @comment.errors }
    end
end
