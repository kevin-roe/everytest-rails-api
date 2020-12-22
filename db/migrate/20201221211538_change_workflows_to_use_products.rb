class ChangeWorkflowsToUseProducts < ActiveRecord::Migration[6.0]
  def change
    WorkflowStep.delete_all
    Workflow.delete_all
    remove_index :workflows, name: "index_workflows_on_test_plan_id"
    rename_column :workflows, :test_plan_id, :product_id
    add_index :workflows, :product_id
  end
end
