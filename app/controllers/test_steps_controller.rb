class TestStepsController < ApplicationController
    include LoggedInConcern
    include ForeignKeyConstraintConcern

    # GET: test_cases/:test_case_id/test_steps - returns all test steps for a test_case  
    def index
        test_steps = TestStep.where(test_case_id: params["test_case_id"])
        render json: test_steps
    end
end