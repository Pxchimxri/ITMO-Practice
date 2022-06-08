class AddNullDetailsToOptions < ActiveRecord::Migration[7.0]
  def change
    change_column_null :options, :name, false
  end
end
