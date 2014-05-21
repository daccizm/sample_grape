module API
  module Shared
    module ParamsScope
      extend Grape::API::Helpers

      params :authentication do
        requires :uuid, type: String
      end

      params :create_user do
        requires :nickname, type: String, max_length: 255
      end

      params :create_device do
        requires :uuid, type: String
        requires :os,   type: String, values: ['ios', 'android']
      end

    end
  end
end