class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :price, null:false
      t.float :interest_rate, null:false
      t.string :tariff, null:false
      t.string :status, null:false
      t.string :from, null:false
      t.string :to, null:false
      t.integer :client_rating
      t.integer :driver_rating
      t.references :client, null: false, foreign_key: {to_table: :users}
      t.references :driver, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
