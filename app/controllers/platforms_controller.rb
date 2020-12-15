class PlatformsController < ApplicationController
    include CurrentOrganizationConcern
    include ForeignKeyConstraintConcern
    before_action :find_platform, only: [:update, :destroy]
    
    # GET - /platforms/:organization_id -- returns all platforms
    def index
        platforms = Platform
                        .where(organization_id: @organization.id)
                        .select([:id, :name])
                        .order(:id)

        render json: platforms
    end

    # POST - /platforms/:organization_id -- creates new platform
    def create
        platform = Platform.new(
            organization_id: @organization.id,
            name: params["name"]
          )

        if platform.save!
            render json: platform.as_json(except: [:organization_id, :created_at, :updated_at]), status: :created
        else
            render json: platform.errors, status: :bad_request
        end
    end

    # PUT - /platforms/:organization_id/:id -- updates one platform
    def update
        @platform.update(platform_params)
        if @platform.errors.count == 0
            render json: @platform.as_json(except: [:organization_id, :created_at, :updated_at]), status: :ok
        else
            render json: @platform.errors, status: :bad_request
        end
    end

    # DELETE - /platforms/:organization_id/:id -- deletes the platform
    def destroy
        @platform.destroy
        head :ok
    end

    private

    def platform_params
        params.require(:platform).permit(:name)
    end


    def find_platform
        @platform = Platform.find_by(
            id: params["id"], 
            organization_id: @organization.id
        )

        if @platform == nil
            head :not_found
        end
    end
end
