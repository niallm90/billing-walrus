user = User.create!(
  :email => 'admin@example.com',
  :password => 'password',
  :password_confirmation => 'password',
  :access_level => User::SUPER_USER
)

misc = Service.create!(:name => "Miscellaneous")
power = Service.create!(:name => "Power")
gas = Service.create!(:name => "Gas")
internet = Service.create!(:name => "Internet")

genesis = Vendor.create(:name => "Genesis Energy")
snap = Vendor.create(:name => "Snap Internet")

power.vendors << genesis
gas.vendors << genesis
internet.vendors << snap

bill = snap.bills.create!(
  :issue_date => Time.now,
  :due_date => Time.now+60,
)
5.times do |i|
  user.slices.create!(
    :amount => (i+1)*10,
    :bill_id => bill.id
  ).payments.create!(
    :amount => (i+1)*5
  )
end
