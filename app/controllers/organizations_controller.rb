class OrganizationsController < ApplicationController
    include CurrentOrganizationConcern

    def update
        @organization.update(org_params)

        if @organization.errors.count > 0
            render json: @organization.errors, status: :bad_request
        else
            render json: @organization, status: :ok
        end
    end

    def org_params
        params.require(:organization).permit(:name)
    end
    
end