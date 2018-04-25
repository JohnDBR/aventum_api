class CreateStops < ActiveRecord::Migration[5.2]
  def change
    create_table :stops do |t|
    	t.belongs_to :journey, index: true
    	t.belongs_to :user, index: true
    	t.string :latitude
    	t.string :longitude
      # t.timestamps
    end
  end
end
