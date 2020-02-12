class UsersController < ApplicationController
    def index
        @user = User.find(current_user.id)
        @users = User.all
        @book = Book.new
    end
    def show
        @user = User.find(params[:id])
        @book = Book.new
        @books = Book.where(user_id:@user.id)
    end
    def edit
        @user = User.find(current_user.id)
    end
    def update
        @user = User.find(current_user.id)
        @user.update(user_params)
        redirect_to user_path(@user.id)

    end
    private
    def user_params
        params.require(:user).permit(:name, :profile_image_id, :introduction)
    end

end
