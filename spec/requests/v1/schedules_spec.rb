describe API do
  describe 'V1' do
    describe 'Schedules' do

      before do
        @schedule1 = create(:schedule1, :owner_user1)
        @schedule1.update_attributes!(guid: 'd8ff3060-eb84-11e3-ac10-0800200c9a66')
        @schedule2 = create(:schedule2, :owner_user2)

        @owner = create(:actor_user1)
        @owner.devices.build( attributes_for(:device1) )
        @owner.save!

        @actor_user = create(:actor_user2)
        @actor_user.devices.build( attributes_for(:device2) )
        @actor_user.save!

        @schedule = build(:new_schedule)
      end

      #
      # 予定詳細取得API
      #
      describe 'GET /v1/schedules/show' do

        before do
          get '/v1/schedules/show', parameters
        end

        context 'パラメータ不正' do

          let(:base_parameters) do
            {
              uuid: @schedule1.user.devices.first.uuid,
              schedule_guid: @schedule1.guid,
            }
          end

          it_should_behave_like '「uuid」欠落' do
            let(:parameters) do
              base_parameters.delete(:uuid)
              base_parameters
            end
          end

          it_should_behave_like '「schedule_guid」欠落' do
            let(:parameters) do
              base_parameters.delete(:schedule_guid)
              base_parameters
            end
          end

          it_should_behave_like '未登録端末からのアクセス' do
            let(:parameters) do
              base_parameters[:uuid] = '50A21988-BAF2-1712-0872-7ED0C7219795'
              base_parameters
            end
          end

          it_should_behave_like '存在しない予定識別IDで検索' do
            let(:parameters) do
              base_parameters[:schedule_guid] = 'none'
              base_parameters
            end
          end
        end

        describe '正常終了' do

          before do
            @schedule1_actors = []
            @schedule1.actors.each do |actor|
              @schedule1_actors << { nickname: actor.user.nickname, uuid: actor.user.devices.first.uuid }
            end
          end

          context 'Request Success' do
            let(:parameters) { {
              uuid: '60A21988-BAF2-1712-0872-7ED0C7219795',
              schedule_guid: 'd8ff3060-eb84-11e3-ac10-0800200c9a66',
            } }
            let(:result) { {
              schedule: {
                guid: @schedule1.guid,
                title: @schedule1.title,
                image: @schedule1.image,
                description: @schedule1.description,
                start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
                end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
                all_day: @schedule1.all_day,
                place: @schedule1.place,
                latitude: @schedule1.latitude,
                longitude: @schedule1.longitude,
                deleted_at: @schedule1.deleted_at.try(:to_s, :scheduletime),
                lock_version: @schedule1.lock_version,
                owner_name: @schedule1.user.nickname,
                actors: @schedule1_actors,
              }
            } }
            it_behaves_like('request success')
          end
        end
      end

      #
      # 予定登録（Act）
      #
      describe 'POST /v1/schedules/create_by_act' do

        before do
          post '/v1/schedules/create_by_act', parameters
        end

        it_should_behave_like '予定登録共通パラメータ不正' do
          let(:base_parameters) do
            {
              uuid: @owner.devices.first.uuid,
              title: @schedule.title,
              image: @schedule.image,
              description: @schedule.description,
              start_datetime: @schedule.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule.end_datetime.to_s(:scheduletime),
              all_day: @schedule.all_day,
              place: @schedule.place,
              latitude: @schedule.latitude,
              longitude: @schedule.longitude,
              actors: [ {nickname: @actor_user.nickname, uuid: @actor_user.devices.first.uuid} ],
            }
          end
        end

        context '参加者パラメータ不正' do

          let(:base_parameters) do
            {
              uuid: @owner.devices.first.uuid,
              title: @schedule.title,
              image: @schedule.image,
              description: @schedule.description,
              start_datetime: @schedule.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule.end_datetime.to_s(:scheduletime),
              all_day: @schedule.all_day,
              place: @schedule.place,
              latitude: @schedule.latitude,
              longitude: @schedule.longitude,
              actors: [ {nickname: @actor_user.nickname, uuid: @actor_user.devices.first.uuid} ],
            }
          end

          it_should_behave_like '「actors」欠落' do
            let(:parameters) do
              base_parameters.delete(:actors)
              base_parameters
            end
          end

          it_should_behave_like '「actors」nickname 欠落' do
            let(:parameters) do
              base_parameters[:actors] = [ {nickname: 'ヤマダ　太郎', uuid: '1234'}, {uuid: '5678'} ]
              base_parameters
            end
          end

          it_should_behave_like '「actors」uuid 欠落' do
            let(:parameters) do
              base_parameters[:actors] = [ {nickname: 'ヤマダ　太郎', uuid: '1234'}, {nickname: 'ヤマダ　次郎'} ]
              base_parameters
            end
          end
        end

        describe '正常終了' do
          context 'Created Success' do
            let(:schedule) do
              Schedule.find_by( title: @schedule.title )
            end
            let(:parameters) do
              {
                uuid: @owner.devices.first.uuid,
                title: @schedule.title,
                image: @schedule.image,
                description: @schedule.description,
                start_datetime: @schedule.start_datetime.to_s(:scheduletime),
                end_datetime: @schedule.end_datetime.to_s(:scheduletime),
                all_day: @schedule.all_day,
                place: @schedule.place,
                latitude: @schedule.latitude,
                longitude: @schedule.longitude,
                actors: [ {nickname: @actor_user.nickname, uuid: @actor_user.devices.first.uuid} ],
              }
            end
            let(:result) do
              {
                schedule: {
                  guid: schedule.guid,
                  lock_version: 0,
                }
              }
            end
            it {expect(schedule.guid.length).to eq 36}
            it_behaves_like('created success')
          end
        end
      end

      #
      # 予定登録（連携アプリ）
      #
      describe 'POST /v1/schedules/create' do

        before do
          post '/v1/schedules/create', parameters
        end

        it_should_behave_like '予定登録共通パラメータ不正' do
          let(:base_parameters) do
            {
              uuid: @owner.devices.first.uuid,
              title: @schedule.title,
              image: @schedule.image,
              description: @schedule.description,
              start_datetime: @schedule.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule.end_datetime.to_s(:scheduletime),
              all_day: @schedule.all_day,
              place: @schedule.place,
              latitude: @schedule.latitude,
              longitude: @schedule.longitude,
            }
          end
        end

        describe '正常終了' do
          context 'Created Success' do
            let(:schedule) do
              Schedule.find_by( title: @schedule.title )
            end
            let(:parameters) do
              {
                uuid: @owner.devices.first.uuid,
                title: @schedule.title,
                image: @schedule.image,
                description: @schedule.description,
                start_datetime: @schedule.start_datetime.to_s(:scheduletime),
                end_datetime: @schedule.end_datetime.to_s(:scheduletime),
                all_day: @schedule.all_day,
                place: @schedule.place,
                latitude: @schedule.latitude,
                longitude: @schedule.longitude,
              }
            end
            let(:result) do
              {
                schedule: {
                  guid: schedule.guid,
                  lock_version: 0,
                }
              }
            end
            it {expect(schedule.guid.length).to eq 36}
            it_behaves_like('created success')
          end
        end
      end

    end
  end
end