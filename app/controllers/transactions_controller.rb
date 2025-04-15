class TransactionsController < ApplicationController
    before_action :set_transaction, only: [:show, :edit, :update, :destroy]

    # GET /finances
    def finances
        @transactions = current_user.transactions

        # Apply period filter
        case params[:period]
        when "Hoy"
            @transactions = @transactions.where("date >= ? AND date <= ?", Date.today.beginning_of_day, Date.today.end_of_day)
        when "Esta semana"
            @transactions = @transactions.where("date >= ? AND date <= ?", Date.today.beginning_of_week, Date.today.end_of_week)
        when "Este año", nil
            @transactions = @transactions.where("date >= ? AND date <= ?", Date.today.beginning_of_year, Date.today.end_of_year)
        end

        # Apply search filter
        if params[:query].present?
            @transactions = @transactions.where("description ILIKE ?", "%#{params[:query]}%")
        end

        # Calculate totals
        @total = @transactions.sum(:amount)
        @expenses = @transactions.where("amount < 0").sum(:amount)
        @income = @transactions.where("amount > 0").sum(:amount)
    end

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
