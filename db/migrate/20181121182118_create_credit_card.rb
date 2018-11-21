class CreateCreditCard < ActiveRecord::Migration[5.2]

  def change
    create_table :credit_cards do |t|
      t.string :name_on_card
      t.string :card_number
      t.integer :exp_month
      t.integer :exp_year
      t.string :cvc
      t.string :zip_code
      t.string :card_type
      t.string :stripe_id
      t.string :last_4_digits
      t.string :cvc_check

      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
