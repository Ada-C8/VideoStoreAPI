class MovieSerializer < ActiveModel::Serializer
  attributes :title, :overview, :release_date, :inventory, :available_inventory, :id
end
