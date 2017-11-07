class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit, :name
end
