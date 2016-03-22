FactoryGirl.define do
  factory :invalid_url, parent: :url do
    base_url "www.john"
  end
end