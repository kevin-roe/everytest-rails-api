class TestStepsController < ApplicationController
    include LoggedInConcern

    # GET: test_cases/:test_case_id/test_steps - returns all test steps for a test_case  
    def index
        test_steps = TestStep.where(test_case_id: params["test_case_id"]).order(:order)
        render json: test_steps
    end

    def update
        params.permit!

        TestStep.transaction do
            TestStep.where(test_case_id: params["test_case_id"]).destroy_all
            test_steps = TestStep.create(params[:_json])
            if test_steps.all?(&:persisted?)
                render json: TestStep.where(test_case_id: params["test_case_id"])
            else
                head :bad_request
                raise ActiveRecord::Rollback
            end
        end
    end
end