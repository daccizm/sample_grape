class CreateSharedEventActors < ActiveRecord::Migration
  def change
    create_table :shared_event_actors do |t|
      t.references :user
      t.references :event

      t.timestamps
    end
  end
end
