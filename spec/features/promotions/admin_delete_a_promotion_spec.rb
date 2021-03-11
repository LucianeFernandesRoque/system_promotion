require 'rails_helper'
describe 'Promotion' do
  context 'delete a promotion'
  it 'successfully' do
    @promotion = create(:promotion)

    user = create(:user)

    login_as(user)
    visit promotions_path
    click_on 'Bloco do eu sozinho'
    click_on 'Apagar'

    expect(page).not_to have_content('Bloco do eu sozinho')
  end
end
