class TestRunController < ApplicationController
    include LoggedInConcern

    def show
        test_run_steps = []
        order = 1
        test_steps = TestStep.where(test_case_id: params["test_case_id"]).order(:order)
        test_steps.each do |test_step|
            if test_step.action != nil
                test_run_steps.push({order: order, workflow: nil, action: test_step.action, notes: test_step.notes})
                order += 1
            elsif test_step.workflow_id != nil
                workflow = Workflow.find(test_step.workflow_id)
                workflow_steps = WorkflowStep.where(workflow_id: test_step.workflow_id)
                workflow_steps.each do |workflow_step|
                    test_run_steps.push({order: order, workflow: workflow.name, action: workflow_step.action, notes: workflow_step.notes})
                    order += 1
                end
            end

        end

        render json: test_run_steps
    end

    def create
        params.permit!
        error_message = ""

        TestRun.transaction do
            test_run = TestRun.create(params[:test_run])
            if test_run.valid?
                steps = []
                params[:test_run_steps].each do |param|
                    steps.push(
                        test_run_id: test_run.id,
                        order: param[:order],
                        action: param[:action],
                        workflow: param[:workflow],
                        notes: param[:notes],
                        result: param[:result]
                    )
                end
                test_run_steps = TestRunStep.create(steps)
                if test_run_steps.all?(&:persisted?)
                    render json: { test_run: test_run, test_run_steps: test_run_steps }, status: :created
                else
                    error_message = "Could not create test run steps"
                    raise ActiveRecord::Rollback
                end
            else
                error_message = "Could not create test run"
            end

            if error_message != ""
                render json: { error: error_message }, status: :bad_request
            end
        end
    end

    def test_run_params
        params.require(:test_run).permit(:test_case_id, :user_id, :notes, :result)
        params.permit(test_run_steps: [:order, :action, :workflow, :notes, :result]).require(:test_run_steps)
    end

end