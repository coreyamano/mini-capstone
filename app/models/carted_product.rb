class CartedProduct < ApplicationRecord
  has_many :users
  has_many :products
  belongs_to :order, optional: true
end
