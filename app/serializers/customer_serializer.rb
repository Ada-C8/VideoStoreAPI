class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :registered_at, :postal_code, :movies_checked_out_count
end
