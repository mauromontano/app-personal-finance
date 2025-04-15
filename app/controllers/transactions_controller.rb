class TransactionsController < ApplicationController
    before_action :set_transaction, only: [:show, :edit, :update, :destroy]

    # GET /finances
    def finances
        @transactions = current_user.transactions

        # Apply period filter
        case params[:period]
        when "Hoy"
            @transactions = @transactions.where("DATE(date) = ?", Date.today)
        when "Esta semana"
            @transactions = @transactions.where("date >= ? AND date <= ?", Date.today.beginning_of_week, Date.today.end_of_week)
        when "Este año", nil
            @transactions = @transactions.where("date >= ? AND date <= ?", Date.today.beginning_of_year, Date.today.end_of_year)
        end

        # Apply search filter
        if params[:query].present?
            @transactions = @transactions.where("lower(description) LIKE ?", "%#{params[:query].downcase}%")
        end

        # Calculate totals
        @total = @transactions.sum(:amount)
        @expenses = @transactions.where("amount < 0").sum(:amount)
        @income = @transactions.where("amount > 0").sum(:amount)

        respond_to do |format|
            format.html
            format.turbo_stream
        end
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

        respond_to do |format|
            if @transaction.save
                format.html { 
                    flash[:notice] = 'Transacción creada exitosamente.'
                    redirect_to finances_path 
                }
                format.turbo_stream { 
                    flash.now[:notice] = 'Transacción creada exitosamente.'
                    render turbo_stream: [
                        turbo_stream.prepend("transactions", partial: "transactions/transaction", locals: { transaction: @transaction }),
                        turbo_stream.update("flash", partial: "shared/flash"),
                        turbo_stream.update("stats", partial: "transactions/stats"),
                    ]
                }
            else
                format.html { 
                    flash[:error] = 'Error al crear la transacción.'
                    redirect_to finances_path 
                }
                format.turbo_stream {
                    flash.now[:error] = 'Error al crear la transacción.'
                    render turbo_stream: turbo_stream.update("flash", partial: "shared/flash")
                }
            end
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
        params.require(:transaction).permit(:amount, :date, :description, :recurring, :category_id, :transaction_type)
    end
end
