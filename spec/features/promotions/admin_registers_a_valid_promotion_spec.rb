require 'rails_helper'

describe 'Promotion' do
  context 'when admin a register a valid promotio'
  it 'and attributes cannot be blank' do
    user = create(:user)

    login_as(user)
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end

  it 'and code must be unique' do
    @promotion = create(:promotion)

    user = create(:user)

    login_as(user)
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Código', with: 'FOLIALOCAWEB'
    click_on 'Salvar'

    expect(page).to have_content('já está em uso')
  end
end
