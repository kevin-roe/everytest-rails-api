class DropWorkflows < ActiveRecord::Migration[6.0]
  def change
    drop_table :workflow_steps
    drop_table :workflows
  end
end
