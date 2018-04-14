class CreateJoinTableUsersJourneys < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :journeys do |t|
    end
  end
end
