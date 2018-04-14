class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :cc, :email, :phone, :location, :profile_picture
end
