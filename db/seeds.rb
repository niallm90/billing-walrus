u = User.create!(
  :email => 'admin@example.com',
  :password => 'password',
  :password_confirmation => 'password'
)

s = Service.create!(:name => "Service")
v = s.vendors.create!(:name => "Vendor")
b = v.bills.create!(
  :issue_date => Time.now,
  :due_date => Time.now+60,
)
5.times do |i|
  u.slices.create!(
    :amount => (i+1)*10,
    :bill => b
  ).payments.create!(
    :amount => (i+1)*5
  )
end
