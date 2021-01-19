class UsersController < ApplicationController

    def new
      @user = User.new
    end

    def create
       @user = User.new(user_params)
       if @user.save
          session[:user_id] = @user.id
          redirect_to user_path(@user)
       else
          render :new
       end
    end

    def show
      if logged_in?
        if current_user.id.to_s == params[:id]
         @user = User.find_by_id(params[:id])
         else
         redirect_to user_path(current_user)
         end
      else
         redirect_to root_path
      end
    end

    private

    def user_params
        params.require(:user).permit(:email, :username, :password)
    end
end
