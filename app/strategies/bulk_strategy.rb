require_relative "base_strategy"

class BulkStrategy < BaseStrategy
  def apply
    if promotion.percentage?
      product.price * quantity * promotion.discount * 1.0 / 100
    else
      promotion.price * quantity
    end
  end

  def applicable?
    quantity >= promotion.min_quantity
  end
end