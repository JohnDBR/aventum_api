class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :first_name, limit: 255
      t.string :last_name, limit: 255
      t.string :cc, limit: 15
      t.integer :coins, limit: 3, default: 10
      t.string :email, limit: 255
      t.string :phone, limit: 10
      t.string :password, limit: 255
      t.float :latitude, limit: 10, default: 0
      t.float :longitude, limit: 10, default: 0
      t.string :profile_picture, limit: 255
      t.timestamps
    end
  end
end
