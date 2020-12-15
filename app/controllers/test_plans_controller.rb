class TestPlansController < ApplicationController
    include CurrentOrganizationConcern
    include ForeignKeyConstraintConcern
    before_action :find_test_plan, only: [:show, :update, :destroy]
   
    # GET - /test_plans -- returns all test suites
    def index
        test_plans = TestPlan
                        .includes([:product, :platform])
                        .where(organization_id: @organization.id)
                        .order(:id)

        render_response(test_plans)
    end

    # GET - /test_plans/:id -- returns one test plan and it's test suites
    def show
        render_response(@test_plan)
    end

    # POST - /test_plans -- creates new test_suite
    def create
        test_plan = TestPlan.new(
            organization_id: @organization.id,
            product_id: params["product_id"],
            platform_id: params["platform_id"],
        )

        if test_plan.save!
            render_response(test_plan)
        else
            render json: test_plan.errors, status: :bad_request
        end

    end

    # PUT - /test_plans/:id -- updates one test plan
    def update
        @test_plan.update(test_plan_params)
        if @test_plan.errors.count == 0
            render_response(@test_plan)
        else
            render json: @test_plan.errors, status: :bad_request
        end
    end

    # DELETE - /test_plans/:id -- deletes the test_plan
    def destroy       
        @test_plan.destroy
        head :ok
    end

    private

    def find_test_plan
        @test_plan = TestPlan
                        .includes([:product, :platform, :test_suites])
                        .find_by(organization_id: @organization.id, id: params["id"])

        if @test_plan == nil
            head :not_found
        end
    end

    def render_response(obj)
        render json: obj.as_json(include: [:product, :platform], except: [:platform_id, :product_id])
    end

    def test_plan_params
        params.require(:test_plan).permit(:product_id, :platform_id)
    end
end