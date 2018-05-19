class TransactionsController < ApplicationController
  before_action :is_student, only: [:search, :show, :create, :update]
  before_action :set_transaction, only: [:show, :update]

  # POST /transactions/search
  def search
    render json: @user.transactions.where(search_params)
  end

  # GET /transactions/:id
  def show
    render json: @transaction
  end

  # POST /transaction
  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      unless @user.update({coins: @user["coins"].to_i + transaction_params["coins"].to_i})
        render json: TRANSACTION_ERROR
      end
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # PUT /transaction
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.permit(:coins, :transaction_code, :kind).merge(status: 'completed', student: @user)
    end

    def search_params
      params.permit(:status)
    end
end
