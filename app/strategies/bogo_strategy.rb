require_relative "base_strategy"

class BogoStrategy < BaseStrategy
  def apply
    product.price * (
      quantity / (promotion.buy + promotion.get) * promotion.buy +
      quantity % (promotion.buy + promotion.get)
    )
  end

  def applicable?
    true
  end
end