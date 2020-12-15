class TestSuitesController < ApplicationController
    include LoggedInConcern
    include ForeignKeyConstraintConcern
    before_action :check_organization, except: [:create, :index]

    # GET: test_plans/:test_plan_id/test_suites - returns all test suites for a test plan  
    def index
        test_suites = TestSuite.includes(:test_cases).where(test_plan_id: params["test_plan_id"]).order(:id)
        render json: test_suites
    end

    # GET: test_suites/:id - shows one test suite and all it's test cases
    def show
        render json: @test_suite
    end

    # POST: test_suites
    def create
        test_suite = TestSuite.new(test_suite_params)
        if test_suite.save!
            render json: test_suite
        else
            head :bad_request
        end
    end

    # PUT: test_suites/:id
    def update
        if @test_suite.update(test_suite_params)
            render json: @test_suite
        else
            render json: test_suite.errors, status: :bad_request
        end
    end

    # DELETE: test_suites/:id
    def destroy 
        if @test_suite.destroy
            head :no_content
        else
            head :bad_request
        end
    end

    private

    def test_suite_params
        params.require(:test_suite).permit(:test_plan_id, :name)
    end

    def check_organization
        @test_suite = TestSuite.find(params["id"])
        if session[:organization_id] != @test_suite.test_plan.organization_id
            head :unauthorized
        end
    end
end