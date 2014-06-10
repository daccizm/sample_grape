module API
  module V1
    class SharedEvents < Grape::API

      include API::V1::Defaults

      resource :shared_events do
        desc "共有中の予定/公開イベントと参加者の一覧を取得"
        params do
          use :authentication, :base_datetime
        end
        get do
          authenticate!
          {
            schedules: [
              { 
                guid: 'hoge',
                title: '○○○の花火大会',
                image: 'hanabi001',
                start_datetime: '201406151900',
                end_datetime: '201406152030',
                deleted_at: '',
                actors: [
                  {nickname: '品川　太郎'},
                  {nickname: '大崎　次郎'},
                  {nickname: '大崎'},
                  {nickname: '五反田　さぶろう'},
                ]
              },
              {
                guid: 'foo',
                title: '京都旅行',
                image: 'travel001',
                start_datetime: '201406171000',
                end_datetime: '201406172200',
                deleted_at: '201406201300',
                actors: [
                  {nickname: '品川　太郎'},
                  {nickname: '大崎'},
                  {nickname: '五反田　さぶろう'},
                ]
              }
            ],
            events: [
              {
                code: 'unic100',
                actors: [
                  {nickname: '品川　太郎'},
                  {nickname: '大崎　次郎'},
                  {nickname: '松江　太郎'},
                  {nickname: '出雲　次郎'},
                ]
              },
              {
                code: 'unic101',
                actors: [
                  {nickname: '品川　太郎'},
                  {nickname: '出雲　次郎'},
                ]
              }
            ]
          }
        end
      end

    end
  end
end