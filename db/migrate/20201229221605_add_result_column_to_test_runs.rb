class AddResultColumnToTestRuns < ActiveRecord::Migration[6.0]
  def change
    add_column :test_runs, :result, :integer
  end
end
