class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :gallery_id
      t.string :file_location

      t.timestamps
    end
  end
end
