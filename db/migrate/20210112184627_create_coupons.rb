class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.references :promotion, null: false, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
