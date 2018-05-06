class Transaction < ApplicationRecord
  # Validations
  validates_presence_of :coins, :status, :transaction_code, :kind
  # Realationship
  belongs_to :student
end
