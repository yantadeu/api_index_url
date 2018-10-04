require 'rails_helper'

RSpec.describe PaginaWeb, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:scheme) }
  it { should validate_presence_of(:url) }

  it 'has a valid factory' do
    expect(FactoryGirl.create(:pagina_web)).to be_valid
  end
end
