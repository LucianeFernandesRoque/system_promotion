class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy
  has_many :product_category_promotions
  has_many :product_categories, through: :product_category_promotions

  validates :name, :code, :discount_rate,
            :coupon_quantity, :expiration_date,
            presence: true
  validates :name, :code, uniqueness: true

  def generate_coupons!
    raise 'Cupons já foram gerados' if coupons.any?

    coupons
      .create_with(created_at: Time.zone.now, updated_at: Time.zone.now)
      .insert_all!(generate_coupons_code)
  end
end

  private

def generate_coupons_code
  ((coupons.count + 1)..coupon_quantity).map do |number|
    { code: "#{code}-#{'%04d' % number}" }
  end
end

