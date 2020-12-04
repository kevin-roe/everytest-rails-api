class TestPlan < ApplicationRecord
  belongs_to :product
  belongs_to :platform

  has_many :test_suites
  
  validates_uniqueness_of :product_id, scope: [:platform_id]
end
