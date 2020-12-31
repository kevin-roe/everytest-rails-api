class TestCase < ApplicationRecord
  belongs_to :test_suite, counter_cache: true
  has_many :test_steps
  has_many :test_runs

  validates_uniqueness_of :name, scope: :test_suite
  validates_length_of :name, minimum: 3
  validates_length_of :name, maximum: 50
end
