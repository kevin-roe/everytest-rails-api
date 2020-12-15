class CreateWorkflows < ActiveRecord::Migration[6.0]
  def change
    create_table :workflows do |t|
      t.references :test_plan, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
