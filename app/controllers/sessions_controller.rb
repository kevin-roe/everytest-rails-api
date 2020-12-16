class SessionsController < ApplicationController
    include CurrentUserConcern
  
    def create
      puts "############## " + "Rails ENV: " + Rails.env
      user = User
              .find_by(email: params["email"])
              .try(:authenticate, params["password"])
  
      if user
        puts "############## " + "Creating session"
        cookies[:user_id] = user.id
        cookies[:organization_id] = user.organization_id
        puts cookies[:user_id]
        puts cookies[:organization_id]
        render json: user.as_json(include: :organization, except: [:organization_id, :password_digest]), status: :created
      else
        puts "############## " + "NOT AUTHORIZED"
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
      cookies.delete :user_id
      cookies.delete :organization_id
      head :no_content
    end
  end