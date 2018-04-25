class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :coins, :cc, :email, :phone, :latitude, :longitude, :profile_picture
end
