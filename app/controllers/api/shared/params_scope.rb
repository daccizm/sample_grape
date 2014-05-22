module API
  module Shared
    module ParamsScope
      extend Grape::API::Helpers

      params :authentication do
        requires :uuid, type: String
      end

      params :user do
        requires :nickname, type: String, max_length: 255
      end

      params :device do
        requires :uuid, type: String
        optional :token, type: String
        requires :os, type: String, values: ['ios', 'android']
      end

    end
  end
end