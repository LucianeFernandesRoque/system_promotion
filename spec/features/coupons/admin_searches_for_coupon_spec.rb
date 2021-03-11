require 'rails_helper'
describe 'Coupons' do
  context 'when click a coupon' do
    it 'searches for a coupon' do
      promotion = Promotion.create!(name: 'Cyber Monday',
                                    coupon_quantity: 100, description: 'Promoção de Cyber Monday', code: 'CYBER15', discount_rate: 15, expiration_date: '22/12/2033')
      promotion.coupons.create!(code: 'PAS0001', status: :active)
      promotion.coupons.create!(code: 'PAS0002', status: :active)
      user = User.create!(email: 'peter_parker@locaweb.com.br', password: '123456')

      login_as user, scope: :user
      visit root_path
      fill_in 'query',	with: 'PAS0001'
      click_on 'Buscar cupom'

      expect(page).to have_current_path(coupons_path, ignore_query: true)
      expect(page).to have_content('PAS0001')
      expect(page).not_to have_content('PAS0002')
      expect(page).to have_content('Cyber Monday')
      expect(page).to have_content('Promoção de Cyber Monday')
      expect(page).to have_content('22/12/2033')
      expect(page).to have_content('15,00%')
    end

    it 'and coupon not found' do
      promotion = Promotion.create!(name: 'Cyber Monday',
                                    coupon_quantity: 100, description: 'Promoção de Cyber Monday', code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      promotion.coupons.create!(code: 'PAS0001', status: :active)
      promotion.coupons.create!(code: 'PAS0002', status: :active)
      user = User.create!(email: 'peter_parker@locaweb.com.br', password: '123456')

      login_as user, scope: :user
      visit root_path
      fill_in 'query', with: 'PAS0007'
      click_on('Buscar cupom')

      expect(page).to have_current_path(coupons_path, ignore_query: true)
      expect(page).not_to have_content('PAS0001')
      expect(page).not_to have_content('PAS0002')
      expect(page).not_to have_content('PAS0007')
      expect(page).to have_content('Nenhum cupom encontrado')
    end
  end
end
