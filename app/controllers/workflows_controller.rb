class WorkflowsController < ApplicationController
    include LoggedInConcern
    include ForeignKeyConstraintConcern
    before_action :check_organization, except: [:create, :index]

    # GET: test_plans/:test_plan_id/workflows - returns all workflows for a test plan  
    def index
        workflows = Workflow.where(test_plan_id: params["test_plan_id"]).order(:id)
        render json: workflows
    end

    # GET: workflows/:id - shows one test suite and all it's test cases
    def show
        render json: @workflow
    end

    # POST: workflows
    def create
        workflow = Workflow.new(workflow_params)
        if workflow.save!
            render json: workflow
        else
            head :bad_request
        end
    end

    # PUT: workflows/:id
    def update
        if @workflow.update(workflow_params)
            render json: @workflow
        else
            render json: workflow.errors, status: :bad_request
        end
    end

    # DELETE: workflows/:id
    def destroy 
        if @workflow.destroy
            head :no_content
        else
            head :bad_request
        end
    end

    private

    def workflow_params
        params.require(:workflow).permit(:test_plan_id, :name)
    end

    def check_organization
        @workflow = Workflow.find(params["id"])
        if session[:organization_id] != @workflow.test_plan.organization_id
            head :unauthorized
        end
    end
end