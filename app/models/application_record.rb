class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  attr_reader :pretty_date
  
  def pretty_date(date)
    d = Date.parse(date)
    return d.strftime('%a %d %b %Y')
  end

end
