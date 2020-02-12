class BooksController < ApplicationController
    before_action :authenticate_user!
    def index
        @user = Book.find(curent_user.id)
        @book = Book.new
        @books = Book.all
    end
    def show
        @book = Book.where(params[:id])
        @user = User.find(id:@book.user_id)
        @new_book = Book.new
    end

    def edit
        @book = Book.find(params[:id])
    end
    def create
        @book = Book.new(book_params)
        @book.save
        redirect_to book_path(@book.id)
    end
    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to book_index_path
    end
    def update
        @book = Book.find(params[:id])
        @book.update(book_params)
        redirect_to book_path(@book.id)
    end

    private
    def book_params
        params.require(:book).permit(:title,:body,:user_id)
    end
end
