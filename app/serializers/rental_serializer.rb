class RentalSerializer < ActiveModel::Serializer
  # has_one :customer
  # has_one :movie
  attributes :customer_id, :due_date, :title, :name, :postal_code, :checkout_date

  def checkout_date
    object.created_at
  end

  def title
    object.movie.title
  end

  def name
    object.customer.name
  end

  def postal_code
    object.customer.postal_code
  end

end
