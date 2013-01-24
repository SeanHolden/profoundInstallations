class AddSlugToAlbums < ActiveRecord::Migration
  def up
    add_column :albums, :slug, :string
  end

  def down
    remove_column :albums, :slug
  end
end
