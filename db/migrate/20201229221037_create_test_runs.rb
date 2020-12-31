class CreateTestRuns < ActiveRecord::Migration[6.0]
  def change
    create_table :test_runs do |t|
      t.integer :test_case_id
      t.integer :user_id
      t.text :notes

      t.timestamps
    end
  end
end
