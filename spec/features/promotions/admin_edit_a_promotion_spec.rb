require 'rails_helper'

describe 'Promotion' do
  context 'when  edit a promotion' do
    it 'successfully' do
      user = create(:user)

      login_as(user)
      @promotion = create(:promotion)

      visit root_path
      click_link 'Promoções'
      click_link 'Bloco do eu sozinho'
      click_link 'Editar'

      fill_in 'Nome', with: 'Bloco do eu sozinho'
      fill_in 'Descrição', with: 'Promoção de carnaval'
      fill_in 'Código', with: 'FOLIALOCAWEB'
      fill_in 'Desconto', with: 5
      fill_in 'Quantidade de cupons', with: 30
      fill_in 'Data de término', with: '14/10/2030'
      click_on 'Salvar'

      expect(page).to have_current_path(promotion_path(Promotion.last))
      expect(page).to have_content('Bloco do eu sozinho')
      expect(page).to have_content('Promoção de carnaval')
      expect(page).to have_content('FOLIALOCAWEB')
      expect(page).to have_content(5)
      expect(page).to have_content(30)
      expect(page).to have_content('14/10/2030')
    end

    it 'and must fill all fields' do
      user = create(:user)

      login_as(user)

      @promotion = create(:promotion)

      visit root_path
      click_link 'Promoções'
      click_link 'Bloco do eu sozinho'
      click_link 'Editar'

      fill_in 'Nome', with: ''
      fill_in 'Descrição', with: ''
      fill_in 'Código', with: ''
      fill_in 'Desconto', with: ''
      fill_in 'Quantidade de cupons', with: ''
      fill_in 'Data de término', with: ''
      click_on 'Salvar'

      expect(page).to have_content('não pode ficar em branco')
    end
  end
end
