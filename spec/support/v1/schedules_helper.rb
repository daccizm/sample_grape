module V1
  module SchedulesHelper

    shared_examples_for '予定登録共通パラメータ不正' do

      it_should_behave_like '「uuid」欠落' do
        let(:parameters) do
          base_parameters.delete(:uuid)
          base_parameters
        end
      end

      it_should_behave_like '「title」欠落' do
        let(:parameters) do
          base_parameters.delete(:title)
          base_parameters
        end
      end

      it_should_behave_like '「image」欠落' do
        let(:parameters) do
          base_parameters.delete(:image)
          base_parameters
        end
      end

      it_should_behave_like '「description」欠落' do
        let(:parameters) do
          base_parameters.delete(:description)
          base_parameters
        end
      end

      it_should_behave_like '「start_datetime」欠落' do
        let(:parameters) do
          base_parameters.delete(:start_datetime)
          base_parameters
        end
      end

      it_should_behave_like '「start_datetime」YYYYMMDDHHmm形式以外' do
        let(:parameters) do
          base_parameters[:start_datetime] = '20140606'
          base_parameters
        end
      end

      it_should_behave_like '「end_datetime」欠落' do
        let(:parameters) do
          base_parameters.delete(:end_datetime)
          base_parameters
        end
      end

      it_should_behave_like '「end_datetime」YYYYMMDDHHmm形式以外' do
        let(:parameters) do
          base_parameters[:end_datetime] = '20140606'
          base_parameters
        end
      end

      it_should_behave_like '「all_day」欠落' do
        let(:parameters) do
          base_parameters.delete(:all_day)
          base_parameters
        end
      end

      it_should_behave_like '「all_day」Boolean以外' do
        let(:parameters) do
          base_parameters[:all_day] = 'OK'
          base_parameters
        end
      end

      it_should_behave_like '「place」欠落' do
        let(:parameters) do
          base_parameters.delete(:place)
          base_parameters
        end
      end

      it_should_behave_like '「latitude」欠落' do
        let(:parameters) do
          base_parameters.delete(:latitude)
          base_parameters
        end
      end

      it_should_behave_like '「longitude」欠落' do
        let(:parameters) do
          base_parameters.delete(:longitude)
          base_parameters
        end
      end

      it_should_behave_like '未登録端末からのアクセス' do
        let(:parameters) do
          base_parameters[:uuid] = '50A21988-BAF2-1712-0872-7ED0C7219795'
          base_parameters
        end
      end
    end

  end
end