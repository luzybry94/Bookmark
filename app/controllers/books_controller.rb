class BooksController < ApplicationController

    before_action :redirect_home_if_not_logged_in
    before_action :find_book, only: [:show, :edit, :update, :destroy]

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
        @book.image.purge
        @book.image.attach(params[:book][:image])
        redirect_to books_path
      else
        @book.build_genre
        render :new
      end
    end

    def index
      if @user = User.find_by_id(params[:user_id])
        if !params[:genre].blank?
          @books = Book.by_genre(params[:genre])
        else
          @books = @user.books.recent_books
        end
      else
        if !params[:genre].blank?
          @books = Book.by_genre(params[:genre])
        else
          @books = Book.recent_books
        end
      end
    end

    def show
      if @book
        @comments = @book.comments
      else
        redirect_to root_path
      end
    end

    def edit
      if !current_user.books.include?(@book)
        redirect_to user_books_path(current_user)
      end
    end

    def update
      if @book.update(book_params)
        @book.image.purge
        @book.image.attach(params[:book][:image])
        redirect_to user_books_path(current_user)
      else
        render :edit
      end
    end

    def destroy
      @book.delete
      redirect_to user_books_path(current_user)
    end

    private

    def book_params
        params.require(:book).permit(:title, :author, :condition, :price, :genre_id, genre_attributes: [:name])
    end

    def find_book
      @book = Book.find_by_id(params[:id])
    end
end
