class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :name
      t.string :slug, index: true, unique: true
      t.timestamps
    end
  end
end
