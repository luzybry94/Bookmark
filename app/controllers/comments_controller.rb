class CommentsController < ApplicationController

    def new

    end

    def create
      @book = Book.find_by_id(params[:comment][:book_id])
      @comment = current_user.comments.build(comment_params)
      if @comment.save
        redirect_to book_path(@book)
      else
        redirect_to book_path(@book)
      end
    end

    def index

    end

    private

    def comment_params
        params.require(:comment).permit(:content, :book_id)
    end
end
