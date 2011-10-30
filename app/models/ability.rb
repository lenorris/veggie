class Ability
  include CanCan::Ability

  def initialize(user)
    
    # Abilities for logged in users (user is not nil):
    if user
      can [:create, :read, :update], [Restaurant, Branch, Dish]
      can [:create, :read], [Comment]
      
    #abilities for guests
    else
      can :read, [Restaurant, Branch, Comment, Dish]
      can :create, User
    end
  end
end
