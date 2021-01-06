class Workflow < ApplicationRecord
  belongs_to :product
  has_many :workflow_steps

  validates_length_of :name, minimum: 3
end
