require "factory_bot"
require_relative "../../app/models/promotion.rb"

FactoryBot.define do
  factory :promotion do
    product_code { "#{(0..1).map { ('A'..'Z').to_a[rand(26)] }.join}1" }
    kind { %w[bogo bulk].sample }
    buy { rand(1..5) }
    get { rand(1..5) }
    bulk_kind { %w[fixed percentage].sample }
    min_quantity { rand(1..5) }
    discount { rand(1..100) }
    price { rand(1.0..100.0).round(2) }

    trait :bogo do
      product_code { "GR1" }
      kind { "bogo" }
      buy { 1 }
      get { 1 }
    end

    trait :bulk_fixed do
      product_code { "SR1" }
      kind { "bulk" }
      bulk_kind { "fixed" }
      min_quantity { 3 }
      price { 4.5 }
    end

    trait :bulk_percentage do
      product_code { "CF1" }
      kind { "bulk" }
      bulk_kind { "percentage" }
      min_quantity { 3 }
      discount { 66.6666666666666666 }
    end
  end
end
