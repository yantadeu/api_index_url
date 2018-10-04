require 'rails_helper'

RSpec.describe Api::V1::ScrapperController, type: :routing do

  describe 'scrap routing' do
    it 'routes POST /api/v1/scrap to scrapper#create' do
      expect(:post => '/api/v1/scrap').to route_to('api/v1/scrapper#create')
    end

    it 'routes GET /api/v1/search to scrapper#search' do
      expect(:get => '/api/v1/search').to route_to('api/v1/scrapper#search')
    end
  end

end
