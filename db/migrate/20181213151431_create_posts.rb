class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.text :video_html
      t.string :slug, index: true, unique: true
      t.timestamps
    end
  end
end
