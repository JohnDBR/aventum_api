class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 255
      t.string :last_name, limit: 255
      t.string :cc, limit: 15
      t.integer :coins, limit: 3, default: 0
      t.string :email, limit: 255
      t.string :phone, limit: 10
      t.string :password, limit: 255
      t.integer:role, limit: 1  
      t.string :location, limit: 255
      t.string :profile_picture, limit: 255
      t.timestamps
    end
  end
end
