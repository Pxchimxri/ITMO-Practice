class AddNullDetailsToTariff < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tariffs, :name, false
  end
end
