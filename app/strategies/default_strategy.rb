require_relative "bogo_strategy"
require_relative "bulk_strategy"

class DefaultStrategy
  def initialize(product, quantity, promotion = nil)
    @product = product
    @quantity = quantity
    @promotion = promotion
  end

  def apply
    return strategy.apply if strategy&.applicable?

    product.price * quantity
  end

  private

  attr_reader :product, :quantity, :promotion

  def strategy
    return unless promotion

    @strategy ||= strategy_class.new(product, quantity, promotion)
  end

  def strategy_class
    Object.const_get("#{promotion.kind.capitalize}Strategy")
  end
end