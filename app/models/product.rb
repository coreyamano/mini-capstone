class Product < ApplicationRecord
  def date_added
    added_at = created_at.strftime("%b %e, %l:%M %p")
    p added_at
  end
end
