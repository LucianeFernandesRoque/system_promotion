class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: { active: 0, inactive: 20, burn: 10 }
  validates :order, presence: true, on: :coupon_burn

  def self.search(search)
    if search
      where(code: search)
    else
      all
    end
  end

  def title
    "#{code} (#{Coupon.human_attribute_name("status.#{status}")})"
  end

  def as_json(options = {})
    super({ methods: %i[discount_rate expiration_date],
            only: %i[] }.merge(options))
  end

  def burn!(order)
    self.order = order
    self.status = :burn
    save!(context: :coupon_burn)
  end

  private

  def discount_rate
    promotion.discount_rate
  end

  def expiration_date
    I18n.l(promotion.expiration_date)
  end
end
