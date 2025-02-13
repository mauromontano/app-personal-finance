class Category < ApplicationRecord
    has_many :transactions

    validates :name, presence: true, uniqueness: true
    validates :image, presence: false
end
