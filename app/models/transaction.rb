class Transaction < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true
  validates :transaction_type, presence: true
  validates :recurring, inclusion: { in: [true, false] }, allow_nil: true
  validates :description, presence: true
end
