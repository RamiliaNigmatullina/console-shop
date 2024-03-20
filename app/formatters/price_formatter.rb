class PriceFormatter
  def initialize(price, currency = "€")
    @price = price
    @currency = currency
  end

  def to_s
    "#{sprintf('%.2f', price)} #{currency}"
  end

  private

  attr_reader :price, :currency
end
