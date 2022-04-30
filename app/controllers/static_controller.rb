class StaticController < ApplicationController

  def dashboard
   query = "SELECT * FROM users"
   @users = ActiveRecord::Base.connection.execute(query)
  
   borrow=0
   lent=0
   query="SELECT u.description,u.amount, u.who_paid_user_id,u.status,u.owes_you_amount,u.who_to_pay_user_id,u.name_of_user_id,u.created_at,u.updated_at,k.name FROM user_expenses as u LEFT JOIN users as k on u.who_to_pay_user_id=k.id where who_to_pay_user_id=#{current_user.id} "
   @expenses = ActiveRecord::Base.connection.execute(query)
   @expenses.each do |param|
    puts param
    if param['status']=="you borrowed"
     borrow=borrow+param['owes_you_amount']
    end
    if param['status']=="you lent"
     lent=lent+param['owes_you_amount']
    end
    
   end
   @total=lent-borrow
   @youareowed=lent
   @youowe=borrow
   query="select * from settle_up_expenses"
   @settle = ActiveRecord::Base.connection.execute(query)
  end
  
  def person
   query = "SELECT * FROM users"
   @users = ActiveRecord::Base.connection.execute(query)
   puts params[:id]
   query="SELECT u.description,u.amount, u.who_paid_user_id,u.status,u.owes_you_amount,u.who_to_pay_user_id,u.name_of_user_id,u.created_at,u.updated_at,k.name FROM user_expenses as u LEFT JOIN users as k on u.who_to_pay_user_id=k.id where who_paid_user_id=#{params[:id]} and who_to_pay_user_id<> #{params[:id]} "

   @expenses = ActiveRecord::Base.connection.execute(query)
   query="select * from settle_up_expenses where who_paid_id=#{params[:id]}"
   @settle = ActiveRecord::Base.connection.execute(query)

  end
end
