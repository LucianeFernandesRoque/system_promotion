class AddOrderToCoupon < ActiveRecord::Migration[6.1]
  def change
    add_column :coupons, :order, :string
  end
end
