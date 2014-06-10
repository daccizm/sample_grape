module API
  module Shared
    module ParamsScope
      extend Grape::API::Helpers

      params :authentication do
        requires :uuid, type: String
      end

      params :base_datetime do
        requires :datetime, type: String, datetime: 14
      end

      params :user do
        requires :nickname, type: String, max_length: 255
      end

      params :device do
        requires :uuid, type: String
        optional :token, type: String
        requires :os, type: String, values: ['ios', 'android']
      end

      params :schedule_key do
        requires :schedule_guid, type: String
      end

      params :schedule do
        requires :title, type: String
        requires :image, type: String
        requires :description, type: String
        requires :start_datetime, type: String, datetime: 12
        requires :end_datetime, type: String, datetime: 12
        requires :all_day, type: Virtus::Attribute::Boolean
        requires :place, type: String
        requires :latitude, type: String
        requires :longitude, type: String
      end

      params :actors do
        requires :actors, type: Array do
          requires :nickname, type: String
          requires :uuid, type: String
        end
      end

    end
  end
end