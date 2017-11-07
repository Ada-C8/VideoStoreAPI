class CustomerSerializer < ActiveModel::Serializer
  attributes :registered_at, :name, :address, :city, :state, :postal_code, :phone
end
