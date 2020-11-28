class Platform < ApplicationRecord
    belongs_to :organization

    validates_presence_of :name
    validates_uniqueness_of :name, scope: :organization_id
    validates_length_of :name, minimum: 3
    validates_length_of :name, maximum: 50
end
