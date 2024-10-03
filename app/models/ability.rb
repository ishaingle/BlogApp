# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :read, Post
    else
      can :manage, Post, user: user
      can :read, Post
      can :manage, Comment, user: user
      can :read, Comment
    end
  end
end
