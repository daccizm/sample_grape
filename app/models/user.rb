class User < ActiveRecord::Base
  has_many :devices
  has_many :schedules

  scope :find_by_uuid, lambda{ |uuid|
  	devices = Device.includes(:user).where(uuid: uuid).references(:user)
    raise ActiveRecord::RecordNotFound.new( I18n.t('activerecord.errors.models.user.not_found_in_database') ) unless devices.first
    devices.first.user
  }

end