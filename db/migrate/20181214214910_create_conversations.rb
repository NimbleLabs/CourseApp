class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.string :status
      t.string :uuid, index: true, unique: true
      t.integer :user_id, index: true, unique: true
      t.string :visitor_id, index: true, unique: true

      t.timestamps
    end
  end
end
