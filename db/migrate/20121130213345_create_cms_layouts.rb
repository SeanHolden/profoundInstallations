class CreateCmsLayouts < ActiveRecord::Migration
  def up
    create_table :cms_layouts do |t|
      t.text :tagline
      t.string :location
      t.string :telephone

      t.timestamps
    end
  end

  def down
    drop_table :cms_layouts
  end
end
