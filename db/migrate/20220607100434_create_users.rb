class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.decimal :balance
      t.float :rating
      t.boolean :active, null:false
      t.string :role, null: false

      t.timestamps
    end
  end
end
