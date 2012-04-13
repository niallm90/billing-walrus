#   t.after_create {|t| t.user.tasks << t}
FactoryGirl.define do
  sequence :name do |i|
    "Name #{i}"
  end

  sequence :email do |i|
    "#{i}@example.com"
  end

  factory :user do
    email { Factory.next :email }
    name { Factory.next :name }
    password "password"
  end

  factory :service do
    name "A service"
  end

  factory :vendor do
    name "A vendor"
  end

  factory :bill do
    association :vendor, :factory => :vendor
    issue_date DateTime.new(1000000)
    due_date DateTime.new(2000000)
  end

  factory :slice do
    association :user, :factory => :user
    association :bill, :factory => :bill
    amount 1000
  end

  factory :payment do
    association :slice, :factory => :slice
    amount 1000
  end

end
