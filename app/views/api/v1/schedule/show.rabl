object @schedule

attributes :guid, :title, :image, :description, :all_day, :place, :latitude, :longitude, :lock_version

node (:start_datetime) { |schedule| schedule.start_datetime.to_s(:scheduletime) }
node (:end_datetime)   { |schedule| schedule.end_datetime.to_s(:scheduletime) }
node (:deleted_at)     { |schedule| schedule.deleted_at.try(:to_s, :scheduletime) }
node (:owner_name)     { |schedule| schedule.user.nickname }

child :actors, root: :actors, object_root: false do
  node(:nickname) { |actor| actor.user.nickname }
  node(:uuid)     { |actor| actor.user.devices.first.uuid }
end