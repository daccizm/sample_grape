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

      describe 'GET /v1/schedules/show' do

        before do
          get '/v1/schedules/show', parameters
        end

        describe 'パラメータ不正' do
          context '「uuid」欠落' do
            let(:parameters) { {
              schedule_guid: '60A21988-BAF2-1712-0872-7ED0C7219795',
            } }
            let(:result) { {uuid: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「schedule_guid」欠落' do
            let(:parameters) { {
              uuid: '60A21988-BAF2-1712-0872-7ED0C7219795',
            } }
            let(:result) { {schedule_guid: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '未登録端末からのアクセス' do
            let(:parameters) { {
              uuid: '50A21988-BAF2-1712-0872-7ED0C7219795',
              schedule_guid: '60A21988-BAF2-1712-0872-7ED0C7219795',
            } }
            let(:result) { '登録されていない端末からアクセスしています。' }
            it_behaves_like('device invalid')
          end
        end

        describe '異常終了' do
          context '存在しない予定識別IDで検索' do
            let(:parameters) { {
              uuid: '60A21988-BAF2-1712-0872-7ED0C7219795',
              schedule_guid: '60A21988-BAF2-1712-0872-7ED0C7219795',
            } }
            let(:result) { '指定された予定は見つかりませんでした。' }
            it_behaves_like('database not found')
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


      describe 'POST /v1/schedules/create_by_act' do

        before do
          post '/v1/schedules/create_by_act', parameters
        end

        describe 'パラメータ不正' do
          context '「uuid」欠落' do
            let(:parameters) { {
              # uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {uuid: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「title」欠落' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              # title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {title: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「image」欠落' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              # image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {image: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「description」欠落' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              # description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {description: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「start_datetime」欠落' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              # start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {start_datetime: ['必ず設定してください。', '日時はYYYYMMDDHHmmで指定して下さい。']} }
            it_behaves_like('parameters invalid')
          end

          context '「start_datetime」YYYYMMDDHHmm形式以外' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: '20140606',
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {start_datetime: ['日時はYYYYMMDDHHmmで指定して下さい。']} }
            it_behaves_like('parameters invalid')
          end

          context '「end_datetime」欠落' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              # end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {end_datetime: ['必ず設定してください。', '日時はYYYYMMDDHHmmで指定して下さい。']} }
            it_behaves_like('parameters invalid')
          end

          context '「end_datetime」YYYYMMDDHHmm形式以外' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: '20140606',
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {end_datetime: ['日時はYYYYMMDDHHmmで指定して下さい。']} }
            it_behaves_like('parameters invalid')
          end

          context '「all_day」欠落' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              # all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {all_day: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「all_day」Boolean以外' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: 'OK',
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {all_day: ['正しく設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「place」欠落' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              # place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {place: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「latitude」欠落' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              # latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {latitude: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「longitude」欠落' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              # longitude: @schedule1.longitude,
              actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {longitude: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「actors」欠落' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              # actors: [ {nickname: 'hoge', uuid: 'bar'} ],
            } }
            let(:result) { {actors: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「actors」nickname 欠落' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'ヤマダ　太郎', uuid: '1234'}, {uuid: '5678'} ],
            } }
            let(:result) { {'actors[nickname]' => ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「actors」uuid 欠落' do
            let(:parameters) { {
              uuid: @schedule1.user.devices.first.uuid,
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'ヤマダ　太郎', uuid: '1234'}, {nickname: 'ヤマダ　次郎'} ],
            } }
            let(:result) { {'actors[uuid]' => ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '未登録端末からのアクセス' do
            let(:parameters) { {
              uuid: '50A21988-BAF2-1712-0872-7ED0C7219795',
              title: @schedule1.title,
              image: @schedule1.image,
              description: @schedule1.description,
              start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
              end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
              all_day: @schedule1.all_day,
              place: @schedule1.place,
              latitude: @schedule1.latitude,
              longitude: @schedule1.longitude,
              actors: [ {nickname: 'ヤマダ　太郎', uuid: '1234'}, {nickname: 'ヤマダ　次郎', uuid: '5678'} ],
            } }
            let(:result) { '登録されていない端末からアクセスしています。' }
            it_behaves_like('device invalid')
          end
        end

        # describe '異常終了' do
        #   context '存在しない参加者が含まれる' do
        #     let(:parameters) { {
        #       uuid: @schedule1.user.devices.first.uuid,
        #       title: @schedule1.title,
        #       image: @schedule1.image,
        #       description: @schedule1.description,
        #       start_datetime: @schedule1.start_datetime.to_s(:scheduletime),
        #       end_datetime: @schedule1.end_datetime.to_s(:scheduletime),
        #       all_day: @schedule1.all_day,
        #       place: @schedule1.place,
        #       latitude: @schedule1.latitude,
        #       longitude: @schedule1.longitude,
        #       actors: [ {nickname: 'ヤマダ　太郎', uuid: '1234'} ],
        #     } }
        #     let(:result) { '指定されたユーザーは見つかりませんでした。' }
        #     it_behaves_like('database not found')
        #   end
        # end

        describe '正常終了' do
          context 'Created Success' do
            let(:schedule) {
              Schedule.find_by( title: @schedule.title )
            }
            let(:parameters) { {
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
            } }
            let(:result) { {
              schedule: {
                guid: schedule.guid,
                lock_version: 0,
              }
            } }
            it {expect(schedule.guid.length).to eq 36}
            it_behaves_like('created success')
          end
        end

      end
    end
  end
end