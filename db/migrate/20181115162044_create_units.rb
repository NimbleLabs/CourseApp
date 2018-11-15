class CreateUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :units do |t|
      t.string :title
      t.text :description
      t.references :course, foreign_key: true
      t.string :slug, index: true, unique: true
      t.timestamps
    end
  end
end
