class AddWorkflows < ActiveRecord::Migration[6.0]
  def change
    create_table :workflows do |t|
      t.references :test_plan, null: false, foreign_key: true
      t.string :name
      t.integer :workflow_steps_count, default: 0

      t.timestamps
    end
  end
end