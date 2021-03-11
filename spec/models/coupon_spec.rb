require 'rails_helper'
describe 'Coupon' do
  context 'when active coupon' do
    it 'status default' do
      coupon = Coupon.new(code: 'NATAL10-0001')
      expect(coupon.title).to eq('NATAL10-0001 (disponível)')
    end

    it 'status active' do
      coupon = Coupon.new(code: 'NATAL10-0001', status: :active)
      expect(coupon.title).to eq('NATAL10-0001 (disponível)')
    end
  end
end
