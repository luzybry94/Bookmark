class SessionsController < ApplicationController

    def welcome
        
    end

    def new

    end
    
    def create
      @user = User.find_by(username: params[:user][:username])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        flash[:message] = "Invalid Credentials. Please try again."
        redirect_to login_path
      end
    end

    def destroy
      current_user
      session.clear
      redirect_to root_path
    end

    def omniauth_google
      @user = User.google_omniauth(auth)
        if @user.save
          session[:user_id] = @user.id
          redirect_to books_path
        else
          redirect_to root_path
        end
    end

    def omniauth_github
      @user = User.github_omniauth(auth)
        if @user.save
          session[:user_id] = @user.id
          redirect_to books_path
        else
          @error = "Email or Username Missing"
          render :welcome
        end
    end

    private

    def auth
      request.env['omniauth.auth']
    end
    
end