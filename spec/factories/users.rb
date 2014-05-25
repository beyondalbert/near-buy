FactoryGirl.define do
  factory :user do
    email "nb_test@test.com"
    password "123456"
    password_confirmation "123456"
  end
  
  trait :with_addresses do
    after :create do |user|
      FactoryGirl.create_list :address, 2, user: user
    end
  end
end
