class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false 
      t.string :phone
      t.string :email, null: false
      t.float :salary, null: false
      t.integer :area, null: false

      t.timestamps
    end
  end
end
