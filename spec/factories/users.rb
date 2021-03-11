FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@locaweb.com.br" }
    password { '123456' }
  end
end
