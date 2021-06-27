class RemoveImageIdFromProduct < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :image_id
  end
end
