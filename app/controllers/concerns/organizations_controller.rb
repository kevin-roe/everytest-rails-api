class OrganizationsController < ApplicationController
    def update
        org = Organization.find(params["id"])
        org.update(org_params)

        if org.errors.count > 0
            render json: org.errors, status: :bad_request
        else
            render json: org, status: :ok
        end
    end

    def org_params
        params.require(:organization).permit(:name)
      end
    
end