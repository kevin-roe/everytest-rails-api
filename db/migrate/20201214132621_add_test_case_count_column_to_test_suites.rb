class AddTestCaseCountColumnToTestSuites < ActiveRecord::Migration[6.0]
  def change
    add_column :test_suites, :test_cases_count, :integer, default: 0
  end
end
