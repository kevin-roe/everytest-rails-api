class SessionsController < ApplicationController
    include CurrentUserConcern
  
    def create
      user = User
              .find_by(email: params["email"])
              .try(:authenticate, params["password"])
  
      if user
        session[:user_id] = user.id
        render json: user.as_json(include: :organization, except: [:organization_id, :password_digest]), status: :created
      else
        head :unauthorized
      end
    end
  
    def logged_in
      if @current_user
        render json: @current_user.as_json(include: :organization, except: [:organization_id, :password_digest]), status: :ok
      else
        head :no_content
      end
    end
  
    def logout
      reset_session
      head :no_content
    end
  end