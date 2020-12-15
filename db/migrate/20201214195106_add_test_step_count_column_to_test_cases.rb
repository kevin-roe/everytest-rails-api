class AddTestStepCountColumnToTestCases < ActiveRecord::Migration[6.0]
  def change
    add_column :test_cases, :test_steps_count, :integer, default: 0
  end
end
