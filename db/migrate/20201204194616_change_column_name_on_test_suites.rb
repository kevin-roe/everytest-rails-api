class ChangeColumnNameOnTestSuites < ActiveRecord::Migration[6.0]
  def change
    rename_column :test_suites, :test_suite_id, :test_plan_id
  end
end
