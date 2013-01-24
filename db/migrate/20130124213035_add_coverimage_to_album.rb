class AddCoverimageToAlbum < ActiveRecord::Migration
  def up
    add_column :albums, :cover_image, :string
  end

  def down
    remove_column :albums, :cover_image
  end
end