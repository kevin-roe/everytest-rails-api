class AddOrganizationidToTestPlans < ActiveRecord::Migration[6.0]
  def change
    add_column :test_plans, :organization_id, :integer
    add_foreign_key :test_plans, :organizations, unique: true
  end
end
