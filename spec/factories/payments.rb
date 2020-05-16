FactoryBot.define do
  factory :payment do
    amount { Faker::Types.rb_integer }
    created { Faker::Time.between(from: DateTime.now - 10, to: DateTime.now) }
    currency { ['usd', 'cent'].sample }
    customer_id { 1 }
    refunded { [true, false].sample }
    paid { [true, false].sample}
  end
end
