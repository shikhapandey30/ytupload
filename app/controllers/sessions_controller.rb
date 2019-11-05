class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

    # def create 
    #   user = Authentication.from_omniauth(request.env["omniauth.auth"])
            

    #   if user
    #     flash[:notice] = "Authentication successful."
    #     sign_in(user)
    #     sign_in_and_redirect(user)
    #   else
    #       flash[:notice] = "Authentication Failed."
    #   end
    # end
  def create
    user = Authentication.from_omniauth(request.env["omniauth.auth"])
    if user
      flash[:notice] = "Authentication successful."
     sign_in :user, user
     redirect_to root_path
    else
        flash[:notice] = "Authentication Failed."
        redirect_to "/users/sign_up"
    end
  end
  def failure
  end

end