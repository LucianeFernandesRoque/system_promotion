require 'rails_helper'

describe 'Coupon' do
  context 'when show' do
    it 'render coupon json with discount' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      get "/api/v1/coupons/#{coupon.code}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('15')
      expect(response.body).to include('22/12/2033')
    end

    it 'coupon not found' do
      get '/api/v1/coupons/ABC123'

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Cupom não encontrado')
    end

    it 'change coupon status' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDER123' } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Cupom utilizado com sucesso')
      expect(coupon.reload).to be_burn
      expect(coupon.reload.order).to eq('ORDER123')
    end

    it 'coupon not found by code' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      @coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      get '/api/v1/coupons/CYBER-0005'

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Cupom não encontrado')
    end

    it 'order must exist' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      post "/api/v1/coupons/#{coupon.code}/burn", params: {}

      expect(response).to have_http_status(:precondition_failed)
    end

    it 'code muste exist' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
