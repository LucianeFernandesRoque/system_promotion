require 'rails_helper'

describe 'Admin registers a promotion' do
  it 'from index page' do
    user = create(:user)

    login_as(user)
    visit root_path
    click_on 'Promoções'

    expect(page).to have_link('Registrar uma promoção',
                              href: new_promotion_path)
  end

  it 'successfully' do
    user = create(:user)
    ProductCategory.create!(name: 'Hospedagem', code: 'Hosp')
    ProductCategory.create!(name: 'E-mail', code: 'email')
    ProductCategory.create!(name: 'Cloud Server Pro', code: 'server')

    login_as(user)
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'

    fill_in 'Nome', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
    check 'Hospedagem'
    check 'E-mail'
    click_on 'Salvar'

    expect(page).to have_current_path(promotion_path(Promotion.last), ignore_query: true)
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('90')
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('E-mail')
    expect(page).not_to have_content('Cloud Server Pro')
    expect(page).to have_link('Voltar')
  end
end
