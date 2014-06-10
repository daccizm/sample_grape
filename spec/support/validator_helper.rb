module ValidatorHelper

  shared_examples_for '未登録端末からのアクセス' do
    let(:result) { '登録されていない端末からアクセスしています。' }
    it_behaves_like('device invalid')
  end

  shared_examples_for '存在しない予定識別IDで検索' do
    let(:result) { '指定された予定は見つかりませんでした。' }
    it_behaves_like('database not found')
  end

  shared_examples_for '「schedule_guid」欠落' do
    let(:result) { {schedule_guid: ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「uuid」欠落' do
    let(:result) { {uuid: ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「title」欠落' do
    let(:result) { {title: ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「image」欠落' do
    let(:result) { {image: ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「description」欠落' do
    let(:result) { {description: ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「start_datetime」欠落' do
    let(:result) { {start_datetime: ['必ず設定してください。', '日時はYYYYMMDDHHmmで指定して下さい。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「start_datetime」YYYYMMDDHHmm形式以外' do
    let(:result) { {start_datetime: ['日時はYYYYMMDDHHmmで指定して下さい。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「end_datetime」欠落' do
    let(:result) { {end_datetime: ['必ず設定してください。', '日時はYYYYMMDDHHmmで指定して下さい。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「end_datetime」YYYYMMDDHHmm形式以外' do
    let(:result) { {end_datetime: ['日時はYYYYMMDDHHmmで指定して下さい。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「all_day」欠落' do
    let(:result) { {all_day: ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「all_day」Boolean以外' do
    let(:result) { {all_day: ['正しく設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「place」欠落' do
    let(:result) { {place: ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「place」欠落' do
    let(:result) { {place: ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「latitude」欠落' do
    let(:result) { {latitude: ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「longitude」欠落' do
    let(:result) { {longitude: ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「actors」欠落' do
    let(:result) { {actors: ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「actors」nickname 欠落' do
    let(:result) { {'actors[nickname]' => ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

  shared_examples_for '「actors」uuid 欠落' do
    let(:result) { {'actors[uuid]' => ['必ず設定してください。']} }
    it_behaves_like('parameters invalid')
  end

end