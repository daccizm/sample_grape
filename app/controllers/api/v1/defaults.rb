module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do

        include API::Shared::Defaults

        # version 'v1', using: :header, vendor: 'users'
        version 'v1', using: :path

      end
    end
  end
end