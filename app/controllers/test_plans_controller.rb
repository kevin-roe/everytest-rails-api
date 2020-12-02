class TestPlansController < ApplicationController
    before_action :set_organization
   
    # GET - /testplans/:organization_id -- returns all products
    def index
        testplans = TestPlan.where(organization_id: @organization.id).select([:id, :platform_id, :product_id]).order(:id)
        render json: testplans
    end

    def show
        testplan = TestPlan.where(organization_id: @organization.id, id: params["id"]).select([:id, :platform_id, :product_id])[0]
        render json: testplan
    end

    # POST - /testplans/:organization_id -- creates new product
    def create
        testplan = TestPlan.create(
            organization_id: @organization.id,
            product_id: params["product_id"],
            platform_id: params["platform_id"],
        )

        if testplan.valid?
            render json: testplan.as_json(except: [:organization_id, :created_at, :updated_at]), status: :created
        else
            render json: testplan.errors, status: :bad_request
        end

    end

    # PUT - /testplans/:organization_id/:id -- updates one product
    def update
        testplan = TestPlan.where(
            id: params["id"], 
            organization_id: @organization.id
        ).first

        if testplan != nil
            testplan.update(test_plan_params)
            if testplan.errors.count == 0
                render json: testplan.as_json(except: [:organization_id, :created_at, :updated_at]), status: :ok
            else
                render json: testplan.errors, status: :bad_request
            end
        else
            render json: {
                error: "Could not find test plan id: " + params["id"]
            }
        end
    end

    # DELETE - /testplans/:organization_id/:id -- deletes the product
    def destroy
        testplan = TestPlan.where(
            id: params["id"], 
            organization_id: @organization.id
        ).first
        
        if testplan != nil
            testplan.destroy
            head :ok
        else
            render json: {
                error: "Could not find test plan id: " + params["id"]
            }
        end
    end

    def test_plan_params
        params.require(:test_plan).permit(:product_id, :platform_id)
    end

    def set_organization
        organization = Organization.find_by(id: params["organization_id"])
        if organization == nil
            render json: {
                error: "Could not find an organization with the id: " + params["organization_id"]
            }, status: :bad_request
        else
            @organization = organization
        end
    end
end