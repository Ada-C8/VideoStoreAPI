class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :registered_at, :postal_code, :phone
end
