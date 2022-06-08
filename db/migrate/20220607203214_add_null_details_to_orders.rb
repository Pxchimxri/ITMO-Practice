class AddNullDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    change_column_null :orders, :interest_rate, false
    change_column_null :orders, :price, false
  end
end
