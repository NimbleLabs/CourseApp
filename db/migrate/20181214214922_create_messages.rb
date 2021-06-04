class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :body
      t.string :status
      t.references :conversation, foreign_key: true
      t.integer :user_id, index: true
      t.string :visitor_id, index: true
      t.timestamps
    end
  end
end
