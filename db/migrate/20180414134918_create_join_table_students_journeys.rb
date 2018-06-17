class CreateJoinTableStudentsJourneys < ActiveRecord::Migration[5.2]
  def change
    create_join_table :students, :journeys do |t|
    end
  end
end