class WorkflowStepsController < ApplicationController

    # GET: workflows/:workflow_id/workflow_steps - returns all workflow steps for a workflow  
    def index
        workflow_steps = WorkflowStep.where(workflow_id: params["workflow_id"]).order(:order)
        render json: workflow_steps
    end

    def update
        params.permit!

        WorkflowStep.transaction do
            WorkflowStep.where(workflow_id: params["workflow_id"]).destroy_all
            workflow_steps = WorkflowStep.create(params[:_json])
            if workflow_steps.all?(&:persisted?)
                render json: WorkflowStep.where(workflow_id: params["workflow_id"])
            else
                head :bad_request
                raise ActiveRecord::Rollback
            end
        end
    end

    def workflow_step_params
        params.require(:workflow_step).permit(:workflow_id, :workflow_step => [:workflow_id, :action, :order, :notes])
    end

end