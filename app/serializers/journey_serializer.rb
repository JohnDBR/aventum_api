class JourneySerializer < ActiveModel::Serializer
  attributes :id, :code, :start, :end, :capacity, :price, :journey_stop, :duration, :tags
end
