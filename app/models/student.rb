class Student < ApplicationRecord
	# Validations
  before_save :create_hashed_password, if: :password_changed?
	validates_presence_of :first_name, :last_name, :cc, :email, :phone, :password, :latitude, :longitude, :coins
  validates_uniqueness_of :email
  validates_uniqueness_of :cc
  # Realationship
  has_many :transactions
  has_and_belongs_to_many :journeys
  # Methods
  def create_hashed_password
    self.password = AUTHENTICATION_SERVICE.password_hash(self.password)
  end
end
