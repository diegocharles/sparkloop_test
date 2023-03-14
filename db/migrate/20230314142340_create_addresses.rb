class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true, null: false
      t.string :address
      t.string :city
      t.string :coordinates
      t.string :postal_code
      t.string :state

      t.timestamps
    end
  end
end
