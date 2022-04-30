class SettleUpExpenseController < ApplicationController
 def create
  @expense = SettleUpExpense.new(:who_paid_id => params[:settle_up_expense][:who_paid_id], :amount => params[:settle_up_expense][:amount].to_i, :to_whom_id => params[:settle_up_expense][:to_whom_id])
  q="select name from users where id=#{params[:settle_up_expense][:who_paid_id]}"
  @u = ActiveRecord::Base.connection.execute(q)
  q="select name from users where id=#{params[:settle_up_expense][:to_whom_id]}"
  @k = ActiveRecord::Base.connection.execute(q)
  
  query = "INSERT INTO settle_up_expenses (amount,who_paid_id,to_whom_id,created_at,updated_at,who_paid_name,to_whom_name) VALUES (#{@expense.amount}, #{@expense.who_paid_id}, #{@expense.to_whom_id},'#{Time.now}','#{Time.now}','#{@u[0]['name']}','#{@k[0]['name']}')"
  
  @expenses = ActiveRecord::Base.connection.execute(query)
  redirect_to root_path, :success => "Successfully Added Settle Up Expense" and return

 end
end
