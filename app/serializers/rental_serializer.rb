class RentalSerializer < ActiveModel::Serializer
  attributes :checkin_date, :checkout_date, :customer_id, :due_date, :id, :movie_id
end
