class TestRun < ApplicationRecord
    belongs_to :user
    belongs_to :test_case
end
