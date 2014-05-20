module API
  module Shared
    module UsersHelpers

      def current_user
        # @current_user = Devise.find(uuid: params[:uuid]).user
        @current_user ||= User.new(nickname: 'hoge')
      end

      def authenticate!
  	    raise API::Shared::Exceptions::AuthenticatedError.new('登録されていない端末からアクセスしています。') unless @current_user
      end

    end
  end
end