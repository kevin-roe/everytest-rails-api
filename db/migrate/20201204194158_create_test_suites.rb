class CreateTestSuites < ActiveRecord::Migration[6.0]
  def change
    create_table :test_suites do |t|
      t.integer :test_suite_id
      t.string :name

      t.timestamps
    end
  end
end
