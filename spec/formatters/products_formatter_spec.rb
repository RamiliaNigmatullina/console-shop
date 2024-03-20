require "spec_helper"
require_relative "../../app/formatters/products_formatter.rb"

RSpec.describe ProductsFormatter do
  subject(:products_formatter) { described_class.new([product1, product2, product3]) }

  let(:product1) { build :product, :green_tea }
  let(:product2) { build :product, :strawberries }
  let(:product3) { build :product, :coffee }

  let(:expected_string) do
    "Product Code | Name         | Price\n" \
    "------------ | ------------ | -----\n" \
    "GR1          | Green Tea    | 3.11 €\n" \
    "SR1          | Strawberries | 5.00 €\n" \
    "CF1          | Coffee       | 11.23 €"
  end

  describe "#to_s" do
    it { expect(products_formatter.to_s).to eq(expected_string) }
  end
end
