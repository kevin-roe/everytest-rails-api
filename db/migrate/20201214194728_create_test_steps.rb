class CreateTestSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :test_steps do |t|
      t.references :test_case, null: false, foreign_key: true
      t.integer :workflow_id
      t.string :action
      t.integer :order
      t.string :notes

      t.timestamps
    end
  end
end
