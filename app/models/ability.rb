class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.admin?
      can :manage, Algorithm
    end

    # User can manage his own algorithms
    can :manage, Algorithm, user_id: user.id

    # User can copy public algorithms
    can :copy, Algorithm, privacy: 'public'
  end
end
