require 'rails_helper'
context 'when user do registration' do
  it 'and receive welcome message' do
    User.create!(email: 'user1@locaweb.com.br', password: '123456')

    visit root_path
    click_on 'Login'
    fill_in 'Email', with: 'user1@locaweb.com.br'
    fill_in 'Password', with: '123456'
    within 'form' do
      click_on 'Login'
    end

    expect(page).to have_current_path(root_path, ignore_query: true)
    expect(page).to have_content('user1@locaweb.com.br')
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).not_to have_link('Login')
    expect(page).to have_link('Logout')
  end

  it 'and log out' do
    user = create(:user)

    login_as(user)

    visit root_path

    expect(page).to have_content('Logout')
    expect(page).not_to have_content('Login')
  end

  it 'user can only login without the locaweb domain' do
    visit root_path
    click_on 'Login'
    click_on 'Sign up'
    fill_in 'Email', with: 'bla@bla.com.br'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    within 'form' do
      click_on 'Sign up'
    end

    expect(page).to have_content(' domínio inválido')
  end
end
