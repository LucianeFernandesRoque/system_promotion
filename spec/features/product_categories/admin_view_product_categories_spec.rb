require 'rails_helper'

describe 'Product_categories' do
  context 'when views product_categories' do
    it 'successfully' do
      @product_categories = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
      @product_categories = ProductCategory.create!(name: 'E-mail', code: 'EMAIL')
      user = User.create!(email: 'peter_parker@locaweb.com.br', password: '123456')

      login_as user, scope: :user
      visit root_path
      click_on 'Categorias de produto'
      expect(page).to have_content('Hospedagem')
      expect(page).to have_content('HOSP')
      expect(page).to have_content('E-mail')
      expect(page).to have_content('EMAIL')
      expect(page).to have_link('Voltar', href: root_path)
    end

    it 'and show empty message' do
      user = User.create!(email: 'peter_parker@locaweb.com.br', password: '123456')

      login_as user, scope: :user
      visit root_path
      click_on 'Categorias de produto'

      expect(page).to have_content('Nenhuma categoria cadastrada')
    end

    it 'and view details' do
      @product_categories = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
      @product_categories = ProductCategory.create!(name: 'E-mail', code: 'EMAIL')
      user = User.create!(email: 'peter_parker@locaweb.com.br', password: '123456')

      login_as user, scope: :user
      visit product_categories_path
      click_on 'Hospedagem'

      expect(page).to have_content('Hospedagem')
      expect(page).to have_content('HOSP')
    end
  end
end
