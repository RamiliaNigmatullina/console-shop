require "spec_helper"
require_relative "../../app/formatters/price_formatter.rb"

RSpec.describe PriceFormatter do
  subject(:price_formatter) { described_class.new(*attrs) }

  let(:attrs) { [price] }
  let(:price) { 3.1075 }

  describe "#to_s" do
    it { expect(price_formatter.to_s).to eq("3.11 €") }

    context "when currency is provided" do
      let(:attrs) { [price, currency] }
      let(:currency) { "$" }

      it { expect(price_formatter.to_s).to eq("3.11 $") }
    end
  end
end
