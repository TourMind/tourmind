desc 'generate order for test'
namespace :data do
    task :generate_order => :environment do
        amt = [50, 100, 200]
        users = User.all
        User.count.times do
            amounts = amt.sample
            user = users.sample
            p user
            order = Order.create(amount: amounts, pay_time: Time.now, status: '付款成功', user_id: user.id)

            if amounts == 50
                grade = '白鑽會員'
            elsif amounts == 100
                grade = '藍鑽會員'
            elsif amounts == 200
                grade = '紅鑽會員'
            end

            user.update(diamond_grade: grade)

            p user
            p '='*20
            p order
        end
        p 'generate order done'
    end 
end