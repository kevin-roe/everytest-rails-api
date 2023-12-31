class TestSuitesController < ApplicationController
    include LoggedInConcern
    include ForeignKeyConstraintConcern
    before_action :check_organization, except: [:create, :index]

    # GET: test_plans/:test_plan_id/test_suites?with_test_cases=(true|false)
    def index
        with_test_cases = ActiveModel::Type::Boolean.new.cast(params["with_test_cases"])
        if with_test_cases
            render json: TestSuite.where(test_plan_id: params["test_plan_id"]).where.not(test_cases_count: 0).order(:id)
        else
            render json: TestSuite.where(test_plan_id: params["test_plan_id"]).order(:id)
        end
    end

    # GET: test_suites/:id - shows one test suite and all it's test cases
    def show
        render json: @test_suite
    end

    # POST: test_suites
    def create
        test_suite = TestSuite.create(test_suite_params)
        if test_suite.valid?
            render json: test_suite
        else
            render json: test_suite.errors.full_messages, status: :bad_request
        end
    end

    # PUT: test_suites/:id
    def update
        if @test_suite.update(test_suite_params)
            render json: @test_suite
        else
            render json: @test_suite.errors.full_messages, status: :bad_request
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