class AddNullDetailsToTypes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :types, :name, false
  end
end
