class CreateSettleUpExpense < ActiveRecord::Migration[6.1]
  def change
    create_table :settle_up_expenses do |t|
      t.decimal :amount
      t.string :who_paid_name
      t.string :to_whom_name
      t.references :who_paid , null:false, foreign_key: {to_table: :users}
      t.references :to_whom, null:false, foreign_key: {to_table: :users}
      
      t.timestamps
    end
  end
end
