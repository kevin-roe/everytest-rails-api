class CreateTestPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :test_plans do |t|
      t.string :name
      t.belongs_to :organization, null: false, foreign_key: true
      t.belongs_to :platform, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end