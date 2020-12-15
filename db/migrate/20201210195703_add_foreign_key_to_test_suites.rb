class AddForeignKeyToTestSuites < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :test_suites, :test_plans, unique: true
  end
end
