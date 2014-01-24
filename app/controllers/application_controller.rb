class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def require_signin!
      if current_user.nil?
        flash[:error] = "You need to sign in or sign up before continuing."
        redirect_to signin_url
      end
    end

    def authorize_admin!
      require_signin!
      # Uses method from tickets_controller to ensure the
      # user is signed in

      unless current_user.admin?
        flash[:alert] = "You must be an admin to do that."
        redirect_to root_path
        # If user is signed in and not an admin, they get the
        # message and redirect to root_path
      end
    end


end
