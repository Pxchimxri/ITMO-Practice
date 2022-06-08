class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :cur_order_id, :integer
  end
end
