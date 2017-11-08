class ApplicationController < ActionController::API

  def build_overdue_array(rentals_array)
    overdues = []

    rentals_array.each do |rental|
      rental_info = {}
      movie = Movie.find_by(id: rental.movie_id)
      rental_info[:title] = movie.title
      rental_info[:checkout_date] = pretty_date(rental.created_at.to_s)
      rental_info[:due_date] = rental.due_date

      overdues << rental_info
    end

    return overdues
  end

  def pretty_date(date)
    d = Date.parse(date)
    return d.strftime('%a %d %b %Y')
  end

end
