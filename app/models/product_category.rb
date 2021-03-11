class ProductCategory < ApplicationRecord
  has_many :product_category_promotions, dependent: :destroy
  validates :name, :code, presence: true
  validates :code, uniqueness: true
end
