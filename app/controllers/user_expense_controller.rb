class UserExpenseController < ApplicationController
 def create
  @expense = UserExpense.new(:description => params[:user_expense][:description], :amount => params[:user_expense][:amount].to_i, :who_paid_user_id => current_user.id)
  

  s=params[:user_expense][:amount].to_d
  f=0.0
  l=params[:user_expense][:user].length()

  l=l-1
  if l!=0
  
   f=(s/l)
  
  end
  k=f.round(2)
  k1=s-k
  
  q="select id,name from users"
  @users = ActiveRecord::Base.connection.execute(q)
  @users.each do |item|
   id=item['id']
   q="select name from users where id=#{params[:user_expense][:who_paid_user_id]}"
   @user = ActiveRecord::Base.connection.execute(q)
   if  (params[:user_expense][:user]).include?(id.to_s)==false and params[:user_expense][:who_paid_user_id]!=item['id'].to_s
    query = "INSERT INTO user_expenses (amount,description,who_paid_user_id,created_at,updated_at,who_to_pay_user_id,status,name_of_user,owes_you_amount) VALUES (#{@expense.amount}, '#{@expense.description}', #{params[:user_expense][:who_paid_user_id]},'#{Time.now}','#{Time.now}',#{item['id']},'Not Involved','#{@user[0]['name']}',0)"
    @expenses = ActiveRecord::Base.connection.execute(query)

   end

   if  (params[:user_expense][:user]).include?(id.to_s)==false and params[:user_expense][:who_paid_user_id]==item['id'].to_s
    query = "INSERT INTO user_expenses (amount,description,who_paid_user_id,created_at,updated_at,who_to_pay_user_id,status,name_of_user,owes_you_amount) VALUES (#{@expense.amount}, '#{@expense.description}', #{params[:user_expense][:who_paid_user_id]},'#{Time.now}','#{Time.now}',#{item['id']},'you lent','#{@user[0]['name']}',#{s})"
    @expenses = ActiveRecord::Base.connection.execute(query)

   end

   if  (params[:user_expense][:user]).include?(id.to_s)==true and params[:user_expense][:who_paid_user_id]==item['id'].to_s
    query = "INSERT INTO user_expenses (amount,description,who_paid_user_id,created_at,updated_at,who_to_pay_user_id,status,name_of_user,owes_you_amount) VALUES (#{@expense.amount}, '#{@expense.description}', #{params[:user_expense][:who_paid_user_id]},'#{Time.now}','#{Time.now}',#{item['id']},'you lent','#{@user[0]['name']}',#{k1})"
    @expenses = ActiveRecord::Base.connection.execute(query)

   end    
   if  (params[:user_expense][:user]).include?(id.to_s)==true and params[:user_expense][:who_paid_user_id]!=item['id'].to_s
    query = "INSERT INTO user_expenses (amount,description,who_paid_user_id,created_at,updated_at,who_to_pay_user_id,status,name_of_user,owes_you_amount) VALUES (#{@expense.amount}, '#{@expense.description}', #{params[:user_expense][:who_paid_user_id]},'#{Time.now}','#{Time.now}',#{item['id']},'you borrowed','#{@user[0]['name']}',#{k})"
    @expenses = ActiveRecord::Base.connection.execute(query)

   end

  end
  redirect_to root_path, :success => "Successfully added" and return
 end
end
