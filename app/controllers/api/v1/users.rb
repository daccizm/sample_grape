module API
  module V1
    class Users < Grape::API

      include API::V1::Defaults

      resource :users do
        desc "ユーザー情報登録"
        params do
          use :user, :device
        end
        get :create do
          {message: '正常に登録しました。'}
        end

        desc "ユーザー情報更新"
        params do
          use :authentication, :user
          optional :token, type: String
        end
        get :update do
        	authenticate!
          {message: '正常に更新しました。'}
        end
      end

    end
  end
end