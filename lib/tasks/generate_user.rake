desc 'generate user for test'
namespace :data do
    task :generate_user => :environment do
        20.times do
            user = User.create(name:Faker::Name.name, email: Faker::Internet.email, password: '1234567890', tel: Faker::PhoneNumber.cell_phone)
            
        end
        p 'generate user done'
    end 
end