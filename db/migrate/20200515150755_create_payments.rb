class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :created
      t.boolean :paid
      t.decimal :amount, precise: 2
      t.string :currency, default: 'usd'
      t.boolean :refunded
      t.references :customer

      t.timestamps null: false
    end
  end
end
