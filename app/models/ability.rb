class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.admin?
      can :manage, Algorithm
    end

    can :copy, Algorithm, user_id: user.id
    can :copy, Algorithm, privacy: 'public'
  end
end
