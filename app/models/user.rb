class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions

  def balance
    incomes = transactions.income.sum(:amount)
    expenses = transactions.expense.sum(:amount)
    incomes - expenses
  end
end
