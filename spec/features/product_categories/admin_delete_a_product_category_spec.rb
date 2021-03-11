require 'rails_helper'

describe 'ProductCategory' do
  context 'when visit show productCategories' do
    it 'successfully' do
      user = create(:user)

      @product_categories = create(:product_category)
      login_as(user)
      visit root_path
      visit 'product_categories'
      click_on 'CLOUD'
      click_on 'Apagar'

      expect(page).not_to have_content('CLOUD')
    end
  end
end
