class CreateOrderOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :order_options do |t|
      t.integer :order_id
      t.integer :option_id


      t.timestamps
    end
  end
end
