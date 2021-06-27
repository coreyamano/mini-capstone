class RenameImageUrlToUrl < ActiveRecord::Migration[6.1]
  def change
    rename_column :images, :image_url, :url
  end
end
