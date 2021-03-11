require 'rails_helper'

describe 'Product_category' do
  context 'when register a product_category'
  it 'successfully' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    ProductCategory.create!(name: 'E-mail', code: 'EMAIL')
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
end
