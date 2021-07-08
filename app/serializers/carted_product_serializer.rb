class CartedProductSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :quantity, :user_id, :status, :order_id
  belongs_to :product
end
