require 'rails_helper'

describe 'GET /api/v1/search' do
  let!(:paginas_web) {
    data = [{:title => 'AAAAAAA'},{:title => 'BBBBBB'}]
    data.map { |p| FactoryGirl.create(:pagina_web, p) }
  }

  before { get '/api/v1/search?q=AAAAAAA' }

  it 'returns HTTP status 200' do
    expect(response).to have_http_status 200
  end

  it 'encontra a pagina A' do
    body = JSON.parse(response.body)
    expect(body.size).to eq(1)
    expect(body[0][0]['title']).to eq('AAAAAAA')
  end
end
