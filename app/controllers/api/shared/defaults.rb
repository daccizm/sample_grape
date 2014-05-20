module API
  module Shared
    module Defaults
      extend ActiveSupport::Concern

      included do
        format :json
        formatter :json, Grape::Formatter::Rabl
        default_format :json

        helpers API::Shared::UsersHelpers

        helpers API::Shared::ParamsScope

        # パラメータ検証エラー
        rescue_from Grape::Exceptions::ValidationErrors do |e|
          Rack::Response.new(
            { error: { code: 11, messages: e.errors } }.to_json,
            e.status,
            { "Content-type" => "application/json" }
          ).finish
        end

        # 認証エラー
        rescue_from API::Shared::Exceptions::AuthenticatedError do |e|
          Rack::Response.new(
            { error: { code: 12, message: e.message } }.to_json,
            401,
            { "Content-type" => "application/json" }
          ).finish
        end

      end
    end
  end
end