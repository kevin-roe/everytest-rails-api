class DropWorkflowsAgain < ActiveRecord::Migration[6.0]
  def change
    drop_table :workflows
  end
end
