class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :content
      t.text :video_html
      t.references :unit, foreign_key: true
      t.string :slug, index: true, unique: true
      t.timestamps
    end
  end
end
