class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new({:access_level => User::UNVERIFIED})

    can :dashboard, User

    if user.verified?
      can :read, :all
    end

    if user.admin?
      can :manage, [Bill, Payment, Service, Slice, Vendor]
    end

    if user.super_user?
      can :manage, :all
    end
  end
end
