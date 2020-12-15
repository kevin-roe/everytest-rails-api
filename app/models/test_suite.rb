class TestSuite < ApplicationRecord
    belongs_to :test_plan
    has_many :test_cases

    validates_uniqueness_of :name, scope: :test_plan
    validates_length_of :name, minimum: 3
    validates_length_of :name, maximum: 50
end
