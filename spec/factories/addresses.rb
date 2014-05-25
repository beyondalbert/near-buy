FactoryGirl.define do
  sequence :content do |n|
    "33010#{n}"
  end
  factory :address do
    content
    detail "网商路"
  end
end
