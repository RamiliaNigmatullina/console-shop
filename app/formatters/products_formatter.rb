class ProductsFormatter
  PRODUCT_CODE = "Product Code"
  NAME = "Name"
  PRICE = "Price"
  TEMPLATE = "%{code} | %{name} | %{price}"

  def initialize(products)
    @products = products
  end

  def to_s
    [header, separator, *content].join("\n")
  end

  private

  attr_reader :products

  def header
    TEMPLATE % { code: PRODUCT_CODE, name: NAME.ljust(max_name_length, " "), price: PRICE }
  end

  def separator
    TEMPLATE % { code: "-" * PRODUCT_CODE.length, name: "-" * max_name_length, price: "-" * PRICE.length }
  end

  def content
    products.map do |product|
      TEMPLATE % { code: formatted_code(product), name: formatted_name(product), price: formatted_price(product) }
    end
  end

  def formatted_code(product)
    product.code.ljust(PRODUCT_CODE.length, " ")
  end

  def formatted_name(product)
    product.name.ljust(max_name_length, " ")
  end

  def formatted_price(product)
    PriceFormatter.new(product.price)
  end

  def max_name_length
    @max_name_length ||= products.map(&:name).max_by(&:length).length
  end
end
