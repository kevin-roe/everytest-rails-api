class AddUniqueIndexToTestPlans < ActiveRecord::Migration[6.0]
  def change
    add_index :test_plans, [:organization_id, :product_id, :platform_id], unique: true, name: 'index_test_plans_on_organization_and_product_and_platform'
  end
end
