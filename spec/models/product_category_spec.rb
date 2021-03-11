require 'rails_helper'
describe 'ProductCategory' do
  context 'when validation' do
    it 'attributes cannot be blank' do
      product_category = ProductCategory.new

      product_category.valid?

      expect(product_category.errors[:name]).to include('não pode ficar em branco')
      expect(product_category.errors[:code]).to include('não pode ficar em branco')
    end

    it 'code must be uniq' do
      product_category = ProductCategory.create!(name: 'Domínio', code: 'DOMINIO')

      product_category = ProductCategory.new(code: 'DOMINIO')

      product_category.valid?

      expect(product_category.errors[:code]).to include('já está em uso')
    end
  end
end
