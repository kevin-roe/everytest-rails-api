module CurrentOrganizationConcern
    extend ActiveSupport::Concern
  
    included do
      before_action :set_organization
    end
  
    def set_organization
        if session[:user_id] == nil || session[:organization_id] == nil
            head :unauthorized
        end

        organization = Organization.find(session[:organization_id])
        if organization == nil  # How did THIS happen???
            render json: {
                error: "Could not find an organization with the id: " + params["organization_id"]
            }, status: :bad_request
        else
            @organization = organization
        end
    end
  end