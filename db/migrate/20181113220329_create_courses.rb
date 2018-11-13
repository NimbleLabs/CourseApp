class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.string :slug, index: true, unique: true
      t.timestamps
    end
  end
end
