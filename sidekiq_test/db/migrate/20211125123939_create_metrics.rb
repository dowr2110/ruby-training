class CreateMetrics < ActiveRecord::Migration[6.1]
  def change
    create_table :metrics do |t|
      t.integer :city_id
      t.float :temp, default: 0.0, null: false
      t.float :min_temp, default: 0.0, null: false
      t.float :max_temp, default: 0.0, null: false
      t.float :wind_speed, default: 0.0, null: false

      t.index :city_id
      t.timestamps
    end
  end
end
