class BaseStrategy
  def initialize(product, quantity, promotion)
    @product = product
    @quantity = quantity
    @promotion = promotion
  end

  def apply
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def applicable?
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  private

  attr_reader :product, :quantity, :promotion
end