require "active_model"

class Promotion
  include ActiveModel::Model

  attr_accessor :product_code, :kind, :buy, :get, :bulk_kind, :min_quantity, :discount, :price

  KINDS = %w[bogo bulk].freeze
  BULK_KINDS = %w[percentage fixed].freeze

  validates :product_code, :kind, presence: true
  validates :kind, inclusion: { in: KINDS }
  validates :buy, :get, presence: true, numericality: { greater_than_or_equal_to: 1 }, if: :bogo?
  validates :bulk_kind, inclusion: { in: BULK_KINDS, allow_blank: true }
  validates :bulk_kind, presence: true, if: :bulk?
  validates :min_quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }, if: :bulk?
  validates :discount, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }, if: :percentage?
  validates :price, presence: true, numericality: { greater_than: 0 }, if: :fixed?

  def bogo?
    kind == "bogo"
  end

  def bulk?
    kind == "bulk"
  end

  def percentage?
    bulk_kind == "percentage"
  end

  def fixed?
    bulk_kind == "fixed"
  end
end
