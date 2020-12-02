class TestPlan < ApplicationRecord
  belongs_to :product
  belongs_to :platform
  
  validates_uniqueness_of :product_id, scope: [:platform_id]
end
