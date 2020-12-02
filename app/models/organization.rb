class Organization < ApplicationRecord
    has_many :users
    has_many :platforms
    has_many :products
    has_many :test_plans

    validates_presence_of :name
    validates_uniqueness_of :name
    validates_length_of :name, minimum: 3
    validates_length_of :name, maximum: 50
end
