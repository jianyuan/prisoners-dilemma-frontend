class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.admin?
      can :manage, Algorithm

      can :manage, GameRound

      can :manage, Submission
    end

    # Cannot submit multiple times
    # cannot :create, Submission do |submission|
    #   user.submissions.where(game_round: submission.game_round).any?
    # end

    if user.persisted?
      # User can copy public algorithms
      can :copy, Algorithm, privacy: 'public'

      # User can manage his own algorithms
      can :manage, Algorithm, user_id: user.id

      # User can submit algorithm only once
      can :submit, GameRound do |game_round|
        game_round.active?
      end
      cannot :submit, GameRound do |game_round|
        user.submitted_to_round?(game_round)
      end
    end

    # Guest can view public algorithms
    can :read, Algorithm, privacy: 'public'

  end
end
