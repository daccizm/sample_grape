class Device < ActiveRecord::Base
  belongs_to :user

  validates :uuid, uniqueness: true
end