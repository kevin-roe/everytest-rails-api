class AddOrderToTestRunSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :test_run_steps, :order, :integer
  end
end
