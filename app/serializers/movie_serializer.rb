class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :release_date
end
