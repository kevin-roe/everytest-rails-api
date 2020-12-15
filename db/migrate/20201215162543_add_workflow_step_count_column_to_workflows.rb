class AddWorkflowStepCountColumnToWorkflows < ActiveRecord::Migration[6.0]
  def change
    add_column :workflows, :workflow_steps_count, :integer, default: 0
  end
end
