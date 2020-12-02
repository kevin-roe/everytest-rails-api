class RemoveTestPlanindex < ActiveRecord::Migration[6.0]
  def change
    remove_index :test_plans, name: "index_test_plans_on_organization_and_product_and_platform"
  end
end
