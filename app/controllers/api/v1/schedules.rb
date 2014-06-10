module API
  module V1
    class Schedules < Grape::API

      include API::V1::Defaults

      resource :schedules do

        #
        # 予定詳細取得
        #
        desc '共有中の予定の詳細情報を取得'
        params do
          use :authentication, :schedule_key
        end
        get 'show', rabl: 'v1/schedule/show' do
          authenticate!
          @schedule = Schedule.find_by( guid: params[:schedule_guid] )
          raise ActiveRecord::RecordNotFound.new( I18n.t('activerecord.errors.models.schedule.not_found_in_database') ) unless @schedule
        end

        #
        # 予定登録（Act!）
        #
        desc "Act!を使用して共有する予定を登録"
        params do
          use :authentication, :schedule, :actors
        end
        include API::Shared::Transaction
        post 'create_by_act', rabl: 'v1/schedule/create_by_act' do
          authenticate!
          @schedule = @current_user.schedules.build(
            title:          params[:title],
            image:          params[:image],
            description:    params[:description],
            start_datetime: params[:start_datetime],
            end_datetime:   params[:end_datetime],
            all_day:        params[:all_day],
            place:          params[:place],
            latitude:       params[:latitude],
            longitude:      params[:longitude],
          )

          actors = [{ user_id: @current_user.id }]
          # params[:actors].each_with_index do |actor, index|
          #   actors[index] = { user_id: User.find_by_uuid( actor[:uuid] ).id }
          # end
          @schedule.actors_attributes = actors
          @schedule.save!

          {message: '正常に更新しました。'}
        end

        #
        # 予定登録（連携アプリ）
        #
        desc "連携アプリを使用して共有する予定を登録"
        params do
          use :authentication, :schedule_key, :schedule
        end
        get 'create' do
          authenticate!
          {message: '正常に登録しました。'}
        end

        #
        # 予定更新
        #
        desc "共有中の予定を更新"
        params do
          use :authentication, :schedule_key, :schedule
        end
        get 'update' do
          authenticate!
          {message: '正常に更新しました。'}
        end

        #
        # 予定削除
        #
        desc "共有中の予定を削除"
        params do
          use :authentication, :schedule_key
        end
        get 'destroy' do
          authenticate!
          {message: '正常に削除しました。'}
        end
     end

    end
  end
end