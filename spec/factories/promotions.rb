FactoryBot.define do
  factory :promotion do
    name { 'Bloco do eu sozinho' }
    description { 'Promoção de carnaval' }
    code { 'FOLIALOCAWEB' }
    discount_rate { 5 }
    coupon_quantity { 20 }
    expiration_date { '14/10/2030' }
  end
end
