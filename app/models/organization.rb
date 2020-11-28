class Organization < ApplicationRecord
    has_many :users

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :name, length: { minimum: 3 }
    validates :name, length: { maximum: 100 }
end
