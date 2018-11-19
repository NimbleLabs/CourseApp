class AddFieldsToLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :index, :integer
    add_column :lessons, :availability, :string
  end
end
