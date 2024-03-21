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

      total + (product ? product_price(product, promotion, quantity) : 0)
    end
  end

  def products_quantity
    basket.each_with_object(Hash.new(0)) { |code, hash| hash[code] += 1 }
  end

  def product_price(product, promotion, quantity)
    if promotion&.bogo?
      apply_bogo_promotion(product, promotion, quantity)
    elsif promotion&.bulk? && quantity >= promotion.min_quantity
      apply_bulk_promotion(product, promotion, quantity)
    else
      product.price * quantity
    end
  end

  def apply_bogo_promotion(product, promotion, quantity)
    product.price * (
      quantity / (promotion.buy + promotion.get) * promotion.buy +
      quantity % (promotion.buy + promotion.get)
    )
  end

  def apply_bulk_promotion(product, promotion, quantity)
    if promotion.percentage?
      product.price * quantity * promotion.discount * 1.0 / 100
    else
      promotion.price * quantity
    end
  end
end
