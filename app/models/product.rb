require "active_model"

class Product
  include ActiveModel::Model

  attr_accessor :code, :name, :price

  validates :code, presence: true
  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
end
