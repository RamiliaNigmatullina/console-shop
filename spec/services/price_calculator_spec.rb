require "spec_helper"
require_relative "../../app/services/price_calculator.rb"

RSpec.describe PriceCalculator do
  subject(:price_calculator) { described_class.new(products: products, promotions: promotions, basket: basket) }

  let(:products) { [product1, product2, product3] }
  let(:promotions) { [promotion1, promotion2, promotion3] }

  let(:product1) { build :product, :green_tea }
  let(:product2) { build :product, :strawberries }
  let(:product3) { build :product, :coffee }

  let(:promotion1) { build :promotion, :bogo }
  let(:promotion2) { build :promotion, :bulk_fixed }
  let(:promotion3) { build :promotion, :bulk_percentage }

  let(:basket) { %w[GR1 SR1 CF1] }

  describe "#total" do
    subject(:total) { price_calculator.total }

    it { is_expected.to eq(19.34) }

    context "with bogo (buy one get one) promotion" do
      let(:basket) { %w[GR1 GR1] }

      it { is_expected.to eq(3.11) }

      context "with 3 items" do
        let(:basket) { %w[GR1 GR1 GR1] }

        it { is_expected.to eq(6.22) }
      end

      context "with 4 items" do
        let(:basket) { %w[GR1 GR1 GR1 GR1] }

        it { is_expected.to eq(6.22) }
      end

      context "with buy 3 get 2 promotion" do
        let(:promotion1) { build :promotion, :bogo, buy: 3, get: 2 }

        it { is_expected.to eq(6.22) }

        context "with 5 items" do
          let(:basket) { %w[GR1 GR1 GR1 GR1 GR1] }

          it { is_expected.to eq(9.33) }
        end

        context "with 7 items" do
          let(:basket) { %w[GR1 GR1 GR1 GR1 GR1 GR1 GR1] }

          it { is_expected.to eq(15.55) }
        end
      end

      context "with buy 1 get 2 promotion" do
        let(:promotion1) { build :promotion, :bogo, get: 2 }

        it { is_expected.to eq(6.22) }

        context "with 3 items" do
          let(:basket) { %w[GR1 GR1 GR1] }

          it { is_expected.to eq(3.11) }
        end
      end
    end

    context "with fixed bulk discount promotion" do
      let(:basket) { %w[SR1 SR1 GR1 SR1] }

      it { is_expected.to eq(16.61) }
    end

    context "with percentage bulk discount promotion" do
      let(:basket) { %w[GR1 CF1 SR1 CF1 CF1] }

      it { is_expected.to eq(30.57) }
    end

    context "with nonexistent product code" do
      let(:basket) { %w[NONEXISTENT_CODE CF1] }

      it { is_expected.to eq(11.23) }
    end

    context "with empty basket" do
      let(:basket) { [] }

      it { is_expected.to eq(0) }
    end
  end
end
