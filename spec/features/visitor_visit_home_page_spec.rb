require 'rails_helper'

describe 'Home' do
  context 'when user visit home page' do
    it 'successfully' do
      visit root_path

      expect(page).to have_content('Sistema de Promoções')
      expect(page).to have_content('Boas vindas ao sistema de gestão de '\
                                   'promoções')
    end
  end
end
