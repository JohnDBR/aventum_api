class Journey < ApplicationRecord
  # Validations
  validates_presence_of :code, :start, :end, :capacity, :price, :journey_stop, :duration, :tags
  # Realationship
  has_and_belongs_to_many :users
  # Methods  
  scope :by_date, -> { order(created_at: :desc) }
end
