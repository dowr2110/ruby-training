class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :phone, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :count
      t.string :date
      t.integer :sum

      t.timestamps
    end
  end
end
