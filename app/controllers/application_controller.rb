class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

    private
    
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
    
    def logged_in?
        !!current_user
    end

    def redirect_home_if_not_logged_in
        if !logged_in?
            redirect_to root_path
        end
    end

    # def redirect_home_if_not_current_user_nested
    #     redirect_to root_path if current_user.id.to_s != params[:user_id]
    # end

    # def redirect_home_if_not_current_user
    #     redirect_to root_path if current_user.id.to_s != params[:id]
    # end

end


