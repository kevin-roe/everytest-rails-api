class WorkflowStep < ApplicationRecord
  belongs_to :workflow, counter_cache: true

  validates :action, presence: true
end
