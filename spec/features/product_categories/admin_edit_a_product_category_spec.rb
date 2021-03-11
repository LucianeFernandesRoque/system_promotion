require 'rails_helper'

describe 'Product category' do
  context 'when edit a product_category' do
    it 'successfully' do
      user = User.create!(email: 'peter_parker@locaweb.com.br', password: '123456')
      login_as user, scope: :user

      @product_category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')

      visit root_path
      click_link 'Categorias de produto'
      click_link 'Hospedagem'
      click_link 'Editar'

      fill_in 'Nome', with: 'E-mail'
      fill_in 'Código', with: 'EMAIL'
      click_on 'Salvar'

      expect(page).to have_current_path(product_category_path(ProductCategory.last), ignore_query: true)
      expect(page).to have_content('E-mail')
      expect(page).to have_content('EMAIL')
    end

    it 'and must fill all fields' do
      user = User.create!(email: 'peter_parker@locaweb.com.br', password: '123456')

      login_as user, scope: :user

      @product_category = ProductCategory.create!(name: 'E-mail', code: 'EMAIL')

      visit root_path
      click_on 'Categorias de produto'
      click_on 'E-mail'
      click_on 'Editar'

      fill_in 'Nome', with: ''
      fill_in 'Código', with: ''
      click_on 'Salvar'

      expect(page).to have_content('não pode ficar em branco')
    end
  end
end
