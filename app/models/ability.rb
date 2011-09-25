class Ability
  include CanCan::Ability

  def initialize(user)
    
    # Abilities for logged in users (user is not nil):
    if user
      can [:create, :read, :update], [Restaurant, Branch]
      
    #abilities for guests
    else
      can :read, [Restaurant, Branch]
      can :create, User
    end
  end
end
