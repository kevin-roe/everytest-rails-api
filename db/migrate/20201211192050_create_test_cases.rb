class CreateTestCases < ActiveRecord::Migration[6.0]
  def change
    create_table :test_cases do |t|
      t.references :test_suite, null: false, foreign_key: true
      t.string :name
      t.integer :mets_id

      t.timestamps
    end
  end
end
