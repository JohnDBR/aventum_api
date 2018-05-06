class Stop < ApplicationRecord
	belongs_to :journey
	has_one :student
	validates_presence_of :latitude, :longitude
end
