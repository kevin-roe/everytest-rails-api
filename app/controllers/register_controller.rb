class RegisterController < ApplicationController
    def create

      trans_rolled_back = false
      error_message = String.new

      Organization.transaction do

        # Create Organization
        organization = Organization.create(
          name: params["organization"]["name"]
        )

        # if organization successfully created, create user
        if organization.valid?
          user = User.create(
            organization_id: organization.id,
            first_name: params['user']['first_name'],
            last_name: params['user']['last_name'],
            email: params['user']['email'],
            password: params['user']['password'],
            password_confirmation: params['user']['password_confirmation'],
            admin: params['user']['admin']
          )

          # if user successfully created, send 201
          if user.valid?
            session[:user_id] = user.id
            render json: {
              organization: organization,
              user: user
            }, status: :created
          
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