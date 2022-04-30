class CreateUserExpense < ActiveRecord::Migration[6.1]
  def change
    create_table :user_expenses do |t|
      t.string :description
      t.decimal :amount
      t.references :who_paid_user, null: false, foreign_key: { to_table: :users }
      t.string :status
      t.decimal :owes_you_amount
      t.references :who_to_pay_user, null:false, foreign_key: {to_table: :users}
      t.string :name_of_user
      t.timestamps
    end
  end
end
