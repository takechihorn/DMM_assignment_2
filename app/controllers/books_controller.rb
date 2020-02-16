class BooksController < ApplicationController
    before_action :authenticate_user!
    def index
        @book = Book.new
        @books = Book.all
    end
    def show
        @books = Book.all
        @book = Book.find(params[:id])
        @user = User.find(@book.user_id)
        @new_book = Book.new
    end

    def edit
        @book = Book.find(params[:id])
        if current_user.id != @book.user_id
            redirect_to books_path
        end
    end
    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
            flash[:notice] = 'successfully!'
            redirect_to book_path(@book.id)
        else
            flash[:notice] = 'error'
            redirect_to books_path
        end
        
    end
    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
    end
    def update
        @book = Book.find(params[:id])

        if @book.update(book_params)
            flash[:notice] = 'You have updated book successfully.!'
            redirect_to book_path(@book.id)
        else
            flash[:notice] = 'error'
            redirect_to book_path
        end
        
    end

    private
    def book_params
        params.require(:book).permit(:title,:body)
    end
end
