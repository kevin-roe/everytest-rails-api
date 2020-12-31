class CreateTestRunSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :test_run_steps do |t|
      t.integer :test_run_id
      t.string :action
      t.string :workflow
      t.integer :result
      t.string :notes

      t.timestamps
    end
  end
end
