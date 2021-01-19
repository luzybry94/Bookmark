class BooksController < ApplicationController

    before_action :redirect_home_if_not_logged_in

    def new
      if current_user.id.to_s == params[:user_id]
        @book = Book.new
        @book.build_genre
      else
        redirect_to root_path
      end
    end

    def create
      @book = current_user.books.build(book_params) 
      if @book.save
        redirect_to books_path
      else
        render :new
      end
    end

    def index
      if @user = User.find_by_id(params[:user_id])
        @books = @user.books.recent_books
      else
        @books = Book.recent_books
      end
    end

    def show
      @book = Book.find_by_id(params[:id])
      if @book
        @comments = @book.comments
      else
        redirect_to root_path
      end
    end

    private

    def book_params
        params.require(:book).permit(:title, :author, :condition, :price, :genre_id, genre_attributes: [:name])
    end
end
