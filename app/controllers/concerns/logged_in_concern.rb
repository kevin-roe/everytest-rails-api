module LoggedInConcern
  extend ActiveSupport::Concern

  included do
    before_action :check_session
  end

  def check_session
    if session[:user_id] == nil || session[:organization_id] == nil
      head :unauthorized
    end
  end
end