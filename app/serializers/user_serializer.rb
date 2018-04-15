class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :coins, :cc, :email, :phone, :location, :profile_picture
end
