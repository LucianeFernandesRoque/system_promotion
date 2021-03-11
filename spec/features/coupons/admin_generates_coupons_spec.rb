require 'rails_helper'

describe 'Coupon' do
  context 'when coupon quantity available' do
    it 'and show generate coupons' do
      @promotion = create(:promotion)

      user = create(:user)

      login_as(user)
      visit root_path
      click_on 'Promoções'
      click_on 'Bloco do eu sozinho'
      click_on 'Emitir cupons'

      expect(page).to have_current_path(promotion_path(@promotion))
      expect(page).to have_content('FOLIALOCAWEB-0001 (disponível)')
      expect(page).to have_content('FOLIALOCAWEB-0002 (disponível)')
      expect(page).to have_content('FOLIALOCAWEB-0003 (disponível)')
      expect(page).to have_content('Cupons gerados com sucesso')
      expect(page).not_to have_link('Emitir cupons')
    end

    it 'and coupons are already generated' do
      promotion = create(:promotion)

      coupon = promotion.coupons.create(code: 'ABCD')
      user = create(:user)

      login_as(user)
      visit promotion_path(promotion)

      expect(page).to have_content(coupon.code)
    end
  end
end
