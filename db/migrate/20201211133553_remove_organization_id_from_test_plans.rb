class RemoveOrganizationIdFromTestPlans < ActiveRecord::Migration[6.0]
  def change
    remove_index :test_plans, name: "index_test_plans_on_organization_id"
    remove_column :test_plans, :organization_id
  end
end
