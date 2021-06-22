class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :tax, :total
end
