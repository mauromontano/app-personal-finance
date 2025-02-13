class TransactionsController < ApplicationController
    before_action :set_transaction, only: [:show, :edit, :update, :destroy]

    # GET /transactions
    def index
        @transactions = current_user.transactions
    end

    # GET /transactions/:id
    def show
    end

    # GET /transactions/new
    def new
        @transaction = current_user.transactions.build
    end

    # GET /transactions/:id/edit
    def edit
    end

    # POST /transactions
    def create
        @transaction = current_user.transactions.build(transaction_params)

        if @transaction.save
            redirect_to @transaction, notice: 'Transaction was successfully created.'
        else
            render :new
        end
    end

    # PATCH/PUT /transactions/:id
    def update
        if @transaction.update(transaction_params)
            redirect_to @transaction, notice: 'Transaction was successfully updated.'
        else
            render :edit
        end
    end

    # DELETE /transactions/:id
    def destroy
        @transaction.destroy
        redirect_to transactions_url, notice: 'Transaction was successfully destroyed.'
    end

    def set_transaction
        @transaction = current_user.transactions.find(params[:id])
    end

    def transaction_params
        params.require(:transaction).permit(:amount, :date, :transaction_type, :recurring, :description, :category_id)
    end
end
