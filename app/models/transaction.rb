class Transaction < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user

  enum :transaction_type, { expense: 0, income: 1 }, prefix: true

  validates :amount, presence: true, numericality: true
  validates :date, presence: true
  validates :transaction_type, presence: true
  validates :recurring, inclusion: { in: [true, false] }, allow_nil: true
  validates :description, presence: true

  scope :expense, -> { where(transaction_type: :expense) }
  scope :income, -> { where(transaction_type: :income) }
end
