class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :student, foreign_key: true
      t.integer :coins, limit: 3
      t.string :status, limit: 15
      t.integer :kind
      t.string :transaction_code, limit: 50
      t.timestamps
    end
  end
end
