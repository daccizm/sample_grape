module API
  module Shared
    module UsersHelpers

      def current_user
        @current_device ||= Device.find_by(uuid: params[:uuid])
        @current_user = @current_device.user if @current_device
      end

      def authenticate!
        current_user
  	    raise API::Shared::Exceptions::AuthenticatedError.new( I18n.t('api.errors.messages.invalid_access.device') ) if @current_device.nil?
      end

    end
  end
end