class RentalSerializer < ActiveModel::Serializer
  attributes :id, :movie_title, :customer_id, :customer_name, :customer_postal_code, :checkout_date, :due_date
end
