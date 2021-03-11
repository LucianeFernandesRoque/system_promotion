require 'rails_helper'

describe 'Promotion' do
  context 'when validation' do
    it 'attributes cannot be blank' do
      promotion = Promotion.new

      promotion.valid?

      expect(promotion.errors[:name]).to include('não pode ficar em branco')
      expect(promotion.errors[:code]).to include('não pode ficar em branco')
      expect(promotion.errors[:discount_rate]).to include('não pode ficar em '\
                                                          'branco')
      expect(promotion.errors[:coupon_quantity]).to include('não pode ficar em'\
                                                            ' branco')
      expect(promotion.errors[:expiration_date]).to include('não pode ficar em'\
                                                            ' branco')
    end

    it 'code must be uniq' do
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033')
      promotion = Promotion.new(code: 'NATAL10')

      promotion.valid?

      expect(promotion.errors[:code]).to include('já está em uso')
    end

    it '#generate_coupons!' do
      promotion = Promotion.create!(name: 'Pascoa', coupon_quantity: 5,
                                    discount_rate: 10, code: 'PASCOA10',
                                    expiration_date: 1.day.from_now)

      promotion.generate_coupons!

      expect(promotion.coupons.count).to eq(5)
      expect(promotion.coupons.map(&:code)).to contain_exactly(
        'PASCOA10-0001', 'PASCOA10-0002', 'PASCOA10-0003', 'PASCOA10-0004',
        'PASCOA10-0005'
      )
    end

    it 'and coupons already generated' do
      promotion = Promotion.create!(name: 'Pascoa', coupon_quantity: 5,
                                    discount_rate: 10, code: 'PASCOA10',
                                    expiration_date: 1.day.from_now)

      promotion.generate_coupons!
      expect { promotion.generate_coupons! }.to raise_error('Cupons já foram gerados')

      expect(promotion.coupons.count).to eq(5)
      expect(promotion.coupons.map(&:code)).to contain_exactly(
        'PASCOA10-0001', 'PASCOA10-0002', 'PASCOA10-0003', 'PASCOA10-0004',
        'PASCOA10-0005'
      )
    end
  end
end
