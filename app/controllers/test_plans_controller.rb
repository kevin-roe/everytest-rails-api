class TestPlansController < ApplicationController
    include CurrentOrganizationConcern
   
    # GET - /test_plans/:organization_id -- returns all products
    def index
        test_plans = TestPlan
                        .includes([:product, :platform])
                        .where(organization_id: @organization.id)
                        .order(:id)

        render_response(test_plans)
    end

    # GET - /test_plans/:organization_id/:id -- returns one product
    def show
        test_plan = TestPlan
                        .includes([:product, :platform, :test_suites])
                        .where(organization_id: @organization.id, id: params["id"])
                        .order(:id)
                        .first

        render json: test_plan.as_json(
            include: { 
                product: { except: [:created_at, :updated_at, :organization_id]}, 
                platform: { except: [:created_at, :updated_at, :organization_id]},
                test_suites: { except: [:created_at, :updated_at, :test_plan_id]},
            },
            except: [:organization_id, :created_at, :updated_at, :platform_id, :product_id]
        )
    end

    # POST - /test_plans/:organization_id -- creates new product
    def create
        test_plan = TestPlan.create(
            organization_id: @organization.id,
            product_id: params["product_id"],
            platform_id: params["platform_id"],
        )

        if test_plan.valid?
            render_response(test_plan)
        else
            render json: test_plan.errors, status: :bad_request
        end

    end

    # PUT - /test_plans/:organization_id/:id -- updates one product
    def update
        test_plan = TestPlan.where(
            id: params["id"], 
            organization_id: @organization.id
        ).first

        if test_plan != nil
            test_plan.update(test_plan_params)
            if test_plan.errors.count == 0
                render_response(test_plan)
            else
                render json: test_plan.errors, status: :bad_request
            end
        else
            render json: {
                error: "Could not find test plan id: " + params["id"]
            }
        end
    end

    # DELETE - /test_plans/:organization_id/:id -- deletes the product
    def destroy
        test_plan = TestPlan.where(
            id: params["id"], 
            organization_id: @organization.id
        ).first
        
        if test_plan != nil
            test_plan.destroy
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
                platform: { except: [:created_at, :updated_at, :organization_id]}
            },
            except: [:organization_id, :created_at, :updated_at, :platform_id, :product_id]
        )
    end

    def test_plan_params
        params.require(:test_plan).permit(:product_id, :platform_id)
    end
end