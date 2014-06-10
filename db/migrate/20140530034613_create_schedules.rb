class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :user
      t.string :guid, :null => false
      t.string :title
      t.string :image
      t.text :description
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.boolean :all_day
      t.string :place
      t.string :latitude
      t.string :longitude
      t.integer :lock_version, :default => 0, :null => false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :schedules, :guid, unique: true

  end
end
