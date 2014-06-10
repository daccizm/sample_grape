class Schedule < ActiveRecord::Base
  belongs_to :user
  has_many :actors, class_name: 'ScheduleActor'

  accepts_nested_attributes_for :actors

  before_create :generate_guid

  private

  def generate_guid
  	self.guid = UUIDTools::UUID.random_create.to_s
  end

end