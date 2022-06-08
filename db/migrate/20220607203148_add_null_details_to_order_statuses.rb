class AddNullDetailsToOrderStatuses < ActiveRecord::Migration[7.0]
  def change
    change_column_null :order_statuses, :name, false
  end
end
