class CreateWorkflowSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :workflow_steps do |t|
      t.references :workflow, null: false, foreign_key: true
      t.string :action
      t.integer :order
      t.string :notes

      t.timestamps
    end
  end
end
