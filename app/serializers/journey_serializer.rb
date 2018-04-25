class JourneySerializer < ActiveModel::Serializer
  attributes :id, :code, :start, :end, :capacity, :price, :duration, :tags
  # has_many :users
  has_many :stops
end
