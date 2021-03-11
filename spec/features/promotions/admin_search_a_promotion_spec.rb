require 'rails_helper'

xfeature 'Visit root_path' do
  context 'and search for promotion' do
    scenario 'successfully' do
      @promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                     code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                     expiration_date: '22/12/2033')

      @promotion = Promotion.create!(name: 'Bloco do eu sozinho', description: 'Carnaval', # tenho que ter uma promocão para poder editar
                                     code: 'FOLIALOCAWEB', discount_rate: 10, coupon_quantity: 50,
                                     expiration_date: '16/02/2024')

      user = User.create!(email: 'peter_parker@locaweb.com.br', password: '123456')
      login_as user, scope: :user

      visit root_path
      click_on 'Promoções'
      fill_in 'Busca:', with: 'Natal'
      click_on 'Pesquisar'

      expect(page).to have_current_path search_path, ignore_query: true
      expect(page).to have_content('Natal')
      expect(page).to have_content('Promoção de natal')
      expect(page).to have_content('NATAL10')
      expect(page).not_to have_content('FOLIALOCAWEB')
      expect(page).not_to have_content('Bloco do eu sozinho')
      expect(page).not_to have_content('Carnaval')
    end

    it 'and cant search results for promotion' do
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                    expiration_date: '22/12/2033')

      user = User.create!(email: 'peter_parker@locaweb.com.br', password: '123456')
      login_as user, scope: :user

      visit root_path
      click_on 'Promoções'
      fill_in 'Busca:', with: 'foo fighters'
      click_on 'Pesquisar'

      expect(page).to have_current_path search_path, ignore_query: true
      expect(page).to have_content('Não encontramos nenhum resultado na sua busca.')
    end
  end
end
