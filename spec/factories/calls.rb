FactoryBot.define do
  factory :call do
    from { FFaker::PhoneNumberJA.international_phone_number.gsub(' ', '') }
    to { FFaker::PhoneNumberJA.international_phone_number.gsub(' ', '') }
    duration { rand(1000) }
    direction { rand(2) }
  end
end
