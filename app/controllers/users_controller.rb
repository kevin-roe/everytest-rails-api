class UsersController < ApplicationController
    wrap_parameters :user, include: [:first_name, :last_name, :email, :admin, :password, :password_confirmation]
    before_action :find_user, only: [:show, :update, :destroy]

    def index
        users = User.where(organization_id: session[:organization_id])
        render json: users
    end

    def show
        render json: @user
    end

    def create
        puts "################"
        puts session[:organization_id]
        user = User.new(
            organization_id: session[:organization_id],
            first_name: params["first_name"],
            last_name: params["last_name"],
            email: params["email"],
            admin: params["admin"],
            password: params["password"],
            password_confirmation: params["password_confirmation"]
        )

        if user.save!
            render json: user, status: :created
        else
            render json: user.errors, status: :bad_request
        end
    end

    def update
        @user.first_name = params["first_name"]
        @user.last_name =  params["last_name"]
        @user.email = params["email"]
        @user.admin = params["admin"]
        @user.password = params["password"] if !params["password"].blank?
        @user.password_confirmation = params["password_confirmation"] if !params["password"].blank?

        if @user.save
            render json: @user.as_json(except: :password_digest)
        else
            puts @user.errors.full_messages
            render json: @user.errors.full_messages, status: :bad_request
        end
    end

    def destroy
        if @user.destroy
            head :no_content
        else
            render json: user.errors, status: :bad_request
        end
    end

    private

    def find_user
        @user = User.find_by(id: params["id"], organization_id: session[:organization_id])
    end
end