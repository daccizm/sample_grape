module API
  module V1
    class Users < Grape::API

      include API::V1::Defaults

      resource :users do

        #
        # ユーザー登録
        #
        desc "ユーザー情報登録"
        include API::Shared::Transaction

        params do
          use :user, :device
        end
        post :create do
          user = User.new( nickname: params[:nickname] )
          user.devices.build(
            uuid:  params[:uuid],
            token: params[:token],
            os:    params[:os],
          )
          user.save!
          { message: '正常に更新しました。' }
        end

        #
        # ユーザー更新
        #
        desc "ユーザー情報更新"
        include API::Shared::Transaction

        params do
          use :authentication, :user
          optional :token, type: String
        end
        patch :update do
        	authenticate!
          @current_user.update_attributes!( nickname: params[:nickname] )
          @current_device.update_attributes!( token: params[:token] )  if params[:token].present?
          { message: '正常に更新しました。' }
        end

      end
    end
  end
end