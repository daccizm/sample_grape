describe API do
  describe 'V1' do
    describe 'Users' do

      before do
        create(:user1, :with_iphone)
        create(:user2, :with_android)
      end

      describe 'POST /v1/users/create' do

        before do
          post '/v1/users/create', parameters
        end

        describe 'パラメータ不正' do
          context '「nickname」欠落' do
            let(:parameters) { {
              uuid: '60A21988-BAF2-1712-0872-7ED0C7219795',
              token: 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7',
              os: 'ios'
            } }
            let(:result) { {nickname: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「uuid」欠落' do
            let(:parameters) { {
              nickname: '品川　太郎',
              token: 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7',
              os: 'ios'
            } }
            let(:result) { {uuid: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「os」欠落' do
            let(:parameters) { {
              nickname: '品川　太郎',
              uuid: '60A21988-BAF2-1712-0872-7ED0C7219795',
              token: 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7',
            } }
            let(:result) { {os: ['必ず設定してください。', '有効な値を設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「os」無効値' do
            let(:parameters) { {
              nickname: '品川　太郎',
              uuid: '60A21988-BAF2-1712-0872-7ED0C7219795',
              token: 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7',
              os: 'windows'
            } }
            let(:result) { {os: ['有効な値を設定してください。']} }
            it_behaves_like('parameters invalid')
          end
        end

        describe '異常終了' do
          context '既に存在するUUIDで登録' do
            let(:parameters) { {
              nickname: '品川　次郎',
              uuid: '60A21988-BAF2-1712-0872-7ED0C7219795',
              token: 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7',
              os: 'ios'
            } }
            let(:result) { {devices: ['既に存在するUUIDです。']} }
            it_behaves_like('record invalid')
          end
        end

        describe '正常終了' do
          context 'Created Success' do
            let(:parameters) { {
              nickname: '品川　太郎',
              uuid: '50A21988-BAF2-1712-0872-7ED0C7219795',
              token: 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7',
              os: 'ios'
            } }
            let(:result) { {message: '正常に更新しました。'} }
            it_behaves_like('created success')
          end
        end
      end


      describe 'PATCH /v1/users/update' do

        before do
          patch '/v1/users/update', parameters
        end

        describe 'パラメータ不正' do
          context '「uuid」欠落' do
            let(:parameters) { {
              token: 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7',
              nickname: '品川　太郎',
            } }
            let(:result) { {uuid: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '「nickname」欠落' do
            let(:parameters) { {
              uuid: '60A21988-BAF2-1712-0872-7ED0C7219795',
              token: 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7',
            } }
            let(:result) { {nickname: ['必ず設定してください。']} }
            it_behaves_like('parameters invalid')
          end

          context '未登録端末からのアクセス' do
            let(:parameters) { {
              uuid: '50A21988-BAF2-1712-0872-7ED0C7219795',
              token: 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7',
              nickname: '品川　太郎',
            } }
            let(:result) { '登録されていない端末からアクセスしています。' }
            it_behaves_like('device invalid')
          end
        end

        describe '正常終了' do
          context 'Updated Success' do
            let(:parameters) { {
              uuid: '60A21988-BAF2-1712-0872-7ED0C7219795',
              token: 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7',
              nickname: '品川　次郎',
            } }
            let(:result) { {message: '正常に更新しました。'} }
            it_behaves_like('request success')
          end
        end
      end

    end
  end
end