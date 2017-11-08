class RentalSerializer < ActiveModel::Serializer
  attributes :movie_id, :customer_id, :pretty_date
end
