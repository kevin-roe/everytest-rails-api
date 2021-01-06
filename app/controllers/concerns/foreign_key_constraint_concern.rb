module ForeignKeyConstraintConcern
    extend ActiveSupport::Concern
  
    included do
        around_action :rescue_from_fk_contraint, only: [:destroy]
    end
  
    def rescue_from_fk_contraint
        begin
          yield
        rescue ActiveRecord::InvalidForeignKey
          head :conflict
        rescue StandardError
          head :bad_request
        end
    end
end