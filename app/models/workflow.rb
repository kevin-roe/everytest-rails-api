class Workflow < ApplicationRecord
  belongs_to :test_plan
  has_many :workflow_steps
end
