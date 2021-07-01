class Product < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :inventory, numericality: { only_integer: true }
  validates :description, length: { in: 10..500 }

  belongs_to :supplier
  has_many :images
  has_many :orders
  has_many :category_products
  has_many :categories, through: :category_products
  #def supplier
  #  Supplier.find_by(id: supplier_id)
  #end

  def is_discounted?
    if price < 10
      true
    else
      false
    end
  end

  def tax
    return price * 0.09
  end

  def total
    return tax + price
  end

  def date_added
    added_at = created_at.strftime("%b %e, %l:%M %p")
    p added_at
  end
end
