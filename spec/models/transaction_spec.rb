require 'rails_helper'

RSpec.describe Transaction, type: :model do
    let(:user) { create(:user) }
    let(:category) { create(:category) }

    context "validations" do
        it "is valid with valid attributes" do
            transaction = Transaction.new(
                amount: 100.0,
                transaction_type: 1,
                date: Date.today,
                description: "Compra supermercado",
                category: category,
                user: user
            )
            expect(transaction).to be_valid
        end

        it "is not valid without an amount" do
            transaction = Transaction.new(
                transaction_type: 1,
                date: Date.today,
                description: "Compra supermercado",
                category: category,
                user: user
            )
            expect(transaction).to_not be_valid
        end
    end
end
