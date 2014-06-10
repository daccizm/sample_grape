module ApiHelper

  shared_examples_for 'request success' do
    it{ response.status.should be(200) }
    it{ JSON.parse(response.body).should match_json_expression(result) }
  end

  shared_examples_for 'created success' do
  	it{ response.status.should be(201) }
  	it{ JSON.parse(response.body).should match_json_expression(result) }
  end

  shared_examples_for 'parameters invalid' do
  	it{ response.status.should be(400) }
  	it{ JSON.parse(response.body).should match_json_expression({ error: { code: 11, messages: result } }) }
  end

  shared_examples_for 'device invalid' do
  	it{ response.status.should be(401) }
  	it{ JSON.parse(response.body).should match_json_expression({ error: { code: 12, message: result } }) }
  end

  shared_examples_for 'record invalid' do
  	it{ response.status.should be(400) }
  	it{ JSON.parse(response.body).should match_json_expression({ error: { code: 13, messages: result } }) }
  end

  shared_examples_for 'database not found' do
    it{ response.status.should be(400) }
    it{ JSON.parse(response.body).should match_json_expression({ error: { code: 14, message: result } }) }
  end

end