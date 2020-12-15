class TestStep < ApplicationRecord
    belongs_to :test_case, counter_cache: true
end
