class RentalSerializer < ActiveModel::Serializer
  attributes :checkout_date, :customer_id, :due_date, :id, :movie_id
end
