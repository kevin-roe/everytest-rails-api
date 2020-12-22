class Workflow < ApplicationRecord
  belongs_to :product
  has_many :workflow_steps
end
