class Journey < ApplicationRecord
  # Validations
  validates_presence_of :code, :start, :end, :capacity, :price, :duration, :tags
  # Realationship
  has_and_belongs_to_many :students
  has_many :stops
  # Methods  
  scope :by_date, -> { order(created_at: :desc) }
end
