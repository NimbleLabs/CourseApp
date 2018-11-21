class AddFieldToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_subscription_id, :string
    add_column :users, :stripe_charge_id, :string
  end
end
