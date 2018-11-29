class AddVistorIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :visitor_id, :string, index: true
  end
end
