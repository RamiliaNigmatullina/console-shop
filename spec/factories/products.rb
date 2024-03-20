require "factory_bot"
require_relative "../../app/models/product.rb"

FactoryBot.define do
  factory :product do
    code { "#{(0..1).map { ('A'..'Z').to_a[rand(26)] }.join}1" }
    name { "Product name" }
    price { rand(1.0..100.0).round(2) }

    trait :green_tea do
      code { "GR1" }
      name { "Green Tea" }
      price { 3.11 }
    end

    trait :strawberries do
      code { "SR1" }
      name { "Strawberries" }
      price { 5.0 }
    end

    trait :coffee do
      code { "CF1" }
      name { "Coffee" }
      price { 11.23 }
    end
  end
end
