module API
  module Shared
    module Defaults
      extend ActiveSupport::Concern

      included do
        require "active_record/validations.rb"

        format :json
        formatter :json, Grape::Formatter::Rabl
        default_format :json

        helpers API::Shared::UsersHelpers

        helpers API::Shared::ParamsScope

        include API::Shared::Validators

        before do
          header 'Content-Type', 'application/json; charset=utf-8'
        end

        # パラメータ検証エラー
        rescue_from Grape::Exceptions::ValidationErrors do |e|
          Rack::Response.new(
            { error: { code: 11, messages: e.errors } }.to_json,
            e.status,
            { "Content-type" => 'application/json; charset=utf-8' }
          ).finish
        end

        # 認証エラー
        rescue_from API::Shared::Exceptions::AuthenticatedError do |e|
          Rack::Response.new(
            { error: { code: 12, message: e.message } }.to_json,
            401,
            { "Content-type" => 'application/json; charset=utf-8' }
          ).finish
        end

        # モデル検証エラー
        rescue_from ActiveRecord::RecordInvalid do |e|
          Rack::Response.new(
            { error: { code: 13, messages: e.record.errors } }.to_json,
            400,
            { "Content-type" => 'application/json; charset=utf-8' }
          ).finish
        end

        # Not Foundエラー
        rescue_from ActiveRecord::RecordNotFound do |e|
          Rack::Response.new(
            { error: { code: 14, message: e.message } }.to_json,
            400,
            { "Content-type" => 'application/json; charset=utf-8' }
          ).finish
        end

      end
    end
  end
end