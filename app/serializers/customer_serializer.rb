class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit, :name, :movies_checked_out_count
end
