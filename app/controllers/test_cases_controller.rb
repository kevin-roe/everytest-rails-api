class TestCasesController < ApplicationController
    include LoggedInConcern
    include ForeignKeyConstraintConcern
    before_action :check_organization, except: [:create, :index]

    # GET: test_suites/:test_suite_id/test_cases
    def index
        test_cases = TestCase.where(test_suite_id: params["test_suite_id"]).order(:id)
        render json: test_cases
    end

    # GET: test_cases/:id
    def show
        render json: @test_case
    end

    # POST: test_cases
    def create
        test_case = TestCase.new(test_case_params)

        if test_case.save
            render json: test_case
        else
            head :bad_request
        end
    end

    # PUT: test_cases/:id
    def update
        if @test_case.update(test_case_params)
            render json: @test_case
        else
            render json: test_case.errors, status: :bad_request
        end
    end

    # DELETE: test_cases/:id
    def destroy 
        if @test_case.destroy
            head :no_content
        else
            head :bad_request
        end
    end

    private

    def test_case_params
        params.require(:test_case).permit(:test_suite_id, :name, :mets_id)
    end

    def check_organization
        @test_case = TestCase.find(params["id"])
        if session[:organization_id] != @test_case.test_suite.test_plan.organization_id
            head :unauthorized
        end
    end
end
