class CreateProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.string :provider_name
      t.string :phone_number

      t.timestamps
    end
  end
end
