require_relative "../strategies/default_strategy"

class PriceCalculator
  def initialize(products:, promotions:, basket:)
    @products = products
    @promotions = promotions
    @basket = basket
    @total = calculate_total
  end

  def total
    @total.round(2)
  end

  private

  attr_reader :products, :promotions, :basket

  def calculate_total
    products_quantity.inject(0) do |total, (code, quantity)|
      product = products.find { |p| p.code == code }
      promotion = promotions.find { |p| p.product_code == code }

      total + (product ? product_price(product, quantity, promotion) : 0)
    end
  end

  def products_quantity
    basket.each_with_object(Hash.new(0)) { |code, hash| hash[code] += 1 }
  end

  def product_price(product, quantity, promotion)
    DefaultStrategy.new(product, quantity, promotion).apply
  end
end
