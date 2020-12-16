module CurrentUserConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user, only: [:logged_in]
  end

  def set_current_user
    puts "############## " + "Session:::"
    puts session[:user_id]
    puts session[:organization_id]
    puts "############## "
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end
end