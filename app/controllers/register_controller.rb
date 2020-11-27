class RegisterController < ApplicationController
    def create

      trans_rolled_back = false
      error_message = String.new

      Organization.transaction do

        # Create Organization
        organization = Organization.create(
          name: params["organization_name"]
        )

        # if organization successfully created, create user
        if organization.valid?
          user = User.create(
            organization_id: organization.id,
            first_name: params['first_name'],
            last_name: params['last_name'],
            email: params['email'],
            password: params['password'],
            password_confirmation: params['password_confirmation'],
            admin: params['admin']
          )

          # if user successfully created, send 201
          if user.valid?
            session[:user_id] = user.id
            render json: user.as_json(include: :organization, except: [:organization_id, :password_digest]), status: :created
          
          # if user not created, delete organization and set trans_rolled_back = true
          else          
            trans_rolled_back = true
            error_message = "Account already exists."
            raise ActiveRecord::Rollback
          end

        # if organization not created, send error message
        else
          render json: {
            error: "Organization already exists!"
          }, status: :bad_request
        end

      end

      # Send response if there was a transaction rolled back
      if trans_rolled_back
        render json: {
          error: error_message
        }, status: :bad_request
      end
    end
  end