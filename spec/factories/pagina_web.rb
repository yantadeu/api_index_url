FactoryGirl.define do
  factory :pagina_web do
    url {Faker::Internet.url}
    title {Faker::Internet.domain_word}
    scheme {'https'}
  end
end