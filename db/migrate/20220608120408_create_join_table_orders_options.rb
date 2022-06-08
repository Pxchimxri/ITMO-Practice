class CreateJoinTableOrdersOptions < ActiveRecord::Migration[7.0]
  def change
    create_join_table :orders, :options do |t|
      t.index :order_id
      t.index :option_id

      t.timestamps
    end
  end
end