module AuthenticationHelper
  def sign_in_super_user
    @user = FactoryGirl.create(:user, {:access_level => User::SUPER_USER})
    sign_in @user
  end
end
