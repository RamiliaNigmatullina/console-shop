require_relative "../spec/factories/products.rb"
require_relative "../spec/factories/promotions.rb"

# Validate records to ensure they are valid.
# This is done because a real database has not been added, to simplify the code.
def add(record, collection)
  if record.valid?
    collection << record
    true
  else
    STDERR.puts record.errors.full_messages
    false
  end
end

def build_entities(entity_factory, *traits)
  traits.map do |trait|
    FactoryBot.build(entity_factory, trait)
  end
end

def products
  @products ||= begin
    build_entities(:product, :green_tea, :strawberries, :coffee).each_with_object([]) do |record, products|
      add(record, products) or abort("Invalid product detected")
    end
  end
end

def promotions
  @promotions ||= begin
    build_entities(:promotion, :bogo, :bulk_fixed, :bulk_percentage).each_with_object([]) do |record, promotions|
      add(record, promotions) or abort("Invalid promotion detected")
    end
  end
end
