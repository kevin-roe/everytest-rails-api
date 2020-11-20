class SessionsController < ApplicationController
    include CurrentUserConcern
  
    def create
      user = User
              .find_by(email: params["user"]["email"])
              .try(:authenticate, params["user"]["password"])
  
      if user
        session[:user_id] = user.id
        organization = Organization.find(user.organization_id)
        render json: {
          logged_in: true,
          organization: organization,
          user: user
        }, status: :ok
      else
        head :unauthorized
      end
    end
  
    def logged_in
      if @current_user
        organization = Organization.find(@current_user.organization_id)
        render json: {
          logged_in: true,
          organization: organization,
          user: @current_user
        }
      else
        render json: {
          logged_in: false
        }
      end
    end
  
    def logout
      reset_session
      render json: { logged_in: true }, status: :ok
    end
  end