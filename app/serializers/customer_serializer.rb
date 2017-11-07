class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :registered_at, :address, :phone, :city, :state, :postal_code, :account_credit
end
