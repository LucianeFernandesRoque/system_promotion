require 'rails_helper'

describe 'Promotions' do
  context 'when admin show a promotion' do
    it 'successfully' do
      @promotion = create(:promotion)

      user = create(:user)

      login_as(user)
      visit root_path
      click_on 'Promoções'

      expect(page).to have_content('Bloco do eu sozinho')
      expect(page).to have_content('Promoção de carnaval')
      expect(page).to have_content(5)
      expect(page).not_to have_content('Nenhuma promoção cadastrada')
      expect(page).to have_link('Voltar', href: root_path)
    end

    it 'and view details' do
      @promotion = create(:promotion)

      user = create(:user)

      login_as(user)
      visit promotions_path
      click_on 'Bloco do eu sozinho'

      expect(page).to have_content('Bloco do eu sozinho')
      expect(page).to have_content('Promoção de carnaval')
      expect(page).to have_content('FOLIALOCAWEB')
      expect(page).to have_content(5)
      expect(page).to have_content(20)
      expect(page).to have_content('14/10/2030')
    end

    it 'and no promotion are created' do
      user = create(:user)

      login_as(user)
      visit root_path
      click_on 'Promoções'

      expect(page).to have_content('Nenhuma promoção cadastrada')
    end

    it 'and return to home page' do
      @promotion = create(:promotion)

      user = create(:user)

      login_as(user)
      visit root_path
      click_on 'Promoções'
      click_on 'Voltar'

      expect(page).to have_current_path root_path, ignore_query: true
    end

    it 'and return to promotions page' do
      @promotion = create(:promotion)

      user = create(:user)

      login_as(user)
      visit promotion_path(@promotion)
      click_on 'Voltar'

      expect(page).to have_current_path promotions_path, ignore_query: true
    end

    it 'and cannot view promotion unless logged in' do
      visit root_path

      expect(page).not_to have_link('Promoções')
    end

    it 'and cannot view promotions unless logged in via link' do
      @promotion = create(:promotion)

      @user = create(:user)

      visit promotions_path

      expect(page).not_to have_content('Natal')
      expect(page).not_to have_link('Promoções')
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
