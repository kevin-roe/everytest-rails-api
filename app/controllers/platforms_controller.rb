class PlatformsController < ApplicationController
    before_action :set_organization
    
    # GET - /platforms/:organization_id -- returns all platforms
    def index
        platforms = Platform.where(organization_id: @organization.id).select([:id, :name]).order(:id)
        render json: platforms
    end

    # POST - /platforms/:organization_id -- creates new platform
    def create
        platform = Platform.create(
            organization_id: @organization.id,
            name: params["name"]
          )

        if platform.valid?
            render json: platform.as_json(except: [:organization_id, :created_at, :updated_at]), status: :created
        else
            render json: platform.errors, status: :bad_request
        end
    end

    # PUT - /platforms/:organization_id/:id -- updates one platform
    def update
        platform = Platform.where(
            id: params["id"], 
            organization_id: @organization.id
        ).first

        if platform != nil
            platform.update(platform_params)
            if platform.errors.count == 0
                render json: platform.as_json(except: [:organization_id, :created_at, :updated_at]), status: :ok
            else
                render json: platform.errors, status: :bad_request
            end
        else
            render json: {
                error: "Could not find platform id: " + params["id"]
            }
        end
    end

    # DELETE - /platforms/:organization_id/:id -- deletes the platform
    def destroy
        platform = Platform.where(
            id: params["id"], 
            organization_id: @organization.id
        ).first
        
        if platform != nil
            platform.destroy
            head :ok
        else
            render json: {
                error: "Could not find platform id: " + params["id"]
            }
        end
    end

    private

    def platform_params
        params.require(:platform).permit(:name)
    end

    def set_organization
        organization = Organization.find_by(id: params["organization_id"])
        if organization == nil
            render json: {
                error: "Could not find an organization with the id: " + params["organization_id"]
            }, status: :bad_request
        else
            @organization = organization
        end
    end
end
