class CreateJourneys < ActiveRecord::Migration[5.2]
  def change
    create_table :journeys do |t|
      t.string :start, limit: 255
      t.string :end, limit: 255      
      t.integer :capacity, limit: 2
      t.integer :price, limit: 3
      t.text :journey_stop, limit: 255
      t.integer :duration, limit: 3
      t.string :status, limit: 15
      t.text :tags
      t.timestamps
    end
  end
end
