class RemoveNameFromTestPlan < ActiveRecord::Migration[6.0]
  def change
    remove_column :test_plans, :name
  end
end
