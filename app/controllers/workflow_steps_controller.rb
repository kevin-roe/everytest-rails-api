class WorkflowStepsController < ApplicationController

    # GET: workflows/:workflow_id/workflow_steps - returns all workflow steps for a workflow  
    def index
        workflow_steps = WorkflowStep.where(workflow_id: params["workflow_id"]).order(:order)
        render json: workflow_steps
    end

end