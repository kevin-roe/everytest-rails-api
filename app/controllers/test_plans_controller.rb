class TestPlansController < ApplicationController
    include CurrentOrganizationConcern
   
    # GET - /test_plans/:organization_id -- returns all products
    def index
        testplans = TestPlan
                        .includes([:product, :platform])
                        .where(organization_id: @organization.id)
                        .order(:id)

        render_response(testplans)
    end

    # GET - /test_plans/:organization_id/:id -- returns one product
    def show
        testplan = TestPlan
                        .includes([:product, :platform])
                        .where(organization_id: @organization.id, id: params["id"])
                        .order(:id)
                        .first

        render_response(testplan)
    end

    # POST - /test_plans/:organization_id -- creates new product
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

    # PUT - /test_plans/:organization_id/:id -- updates one product
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

    # DELETE - /test_plans/:organization_id/:id -- deletes the product
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

    private 

    def render_response(obj)
        render json: obj.as_json(
            include: { 
                product: { except: [:created_at, :updated_at, :organization_id]}, 
                platform: { except: [:created_at, :updated_at, :organization_id]}},
            except: [:organization_id, :created_at, :updated_at, :platform_id, :product_id]
        )
    end

    def test_plan_params
        params.require(:test_plan).permit(:product_id, :platform_id)
    end
end