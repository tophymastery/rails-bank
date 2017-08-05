module api do
  module v1 do
    class BankAccountsController < ApplicationController
      def new_transaction
        amount = params[:amount]
        transaction_type = params[:transaction_type]
        bank_account_id = params[:bank_account_id]

        errors = ::BankAccount::ValidateNewTransaction.new(
                  amount: amount,
                  transaction_type: transaction_type,
                  bank_account_id: bank_account_id
                ).execute!

        if errors.size > 0
          render json: { errors: errors }, status: 402
        else
          bank_account = ::BankAccount::PerformTransaction.new(
                          amount: amount,
                          transaction_type: transaction_type,
                          bank_account_id: bank_account_id
                          ).execute!
          render json: { balance: bank_account.balance }
        end
      end
    end
  end
end