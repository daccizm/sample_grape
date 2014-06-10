class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :uuid, :null => false
      t.string :token
      t.string :os
      t.references :user

      t.timestamps
    end

    add_index :devices, :uuid, unique: true

  end
end
