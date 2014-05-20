module API
  module V1
    class Users < Grape::API

      include API::V1::Defaults

      resource :users do
        desc "ユーザー情報登録"
        params do
          use :create_user, :create_device
        end
        get :create do
          current_user
        end

        desc "ユーザー情報更新"
        params do
          use :authentication, :create_user
        end
        get :update do
        	authenticate!
        	current_user
        end
      end

    end
  end
end