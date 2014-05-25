FactoryGirl.define do
  factory :item do
    subject "test_item"
    description "test_description"
    price 18
    status 2
  end

  trait :with_trades do
    after :create do |item|
      FactoryGirl.create_list :trade, 2, item: item
    end
  end
end
