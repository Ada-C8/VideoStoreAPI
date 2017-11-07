class CustomerSerializer < ActiveModel::Serializer
  attributes :registered_at, :name, :address, :city, :state, :postal_code, :phone, :movies_checked_out
end
