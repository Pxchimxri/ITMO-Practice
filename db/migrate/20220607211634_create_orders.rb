class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :price
      t.float :interest_rate
      t.string :tariff
      t.string :status
      t.string :from
      t.string :to
      t.integer :client_rating
      t.integer :driver_rating
      t.references :client, null: false, foreign_key: {to_table: :users}
      t.references :driver, null: false, foreign_key: {to_table: :users}
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
