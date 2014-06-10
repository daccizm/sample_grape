class CreateScheduleActors < ActiveRecord::Migration
  def change
    create_table :schedule_actors do |t|
      t.references :user
      t.references :schedule

      t.timestamps
    end
  end
end
