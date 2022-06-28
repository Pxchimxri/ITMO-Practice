# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    user ||= User.new # guest user (not logged in)

    # return unless user.present? # additional permissions for logged in users (they can read their own posts)

    can :manage, User, id: user.id

    if user.driver?
      can %i[show index close pick_up_passenger], Order, driver_id: user.id
      can %i[show index cancel accept], Order, status: 'looking_for_driver'
    end

    if user.client?
      can %i[create], Order
      can %i[show edit update index cancel rate_page rate skip_rate], Order, client_id: user.id
    end

    return unless user.admin? # additional permissions for administrators

    can :manage, :all

    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
