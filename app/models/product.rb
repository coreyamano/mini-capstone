class Product < ApplicationRecord
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
    tax + price
  end

  def date_added
    added_at = created_at.strftime("%b %e, %l:%M %p")
    p added_at
  end
end
