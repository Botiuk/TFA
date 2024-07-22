# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, :main

    # if user.present?

    #   if user.role == "fan"

    #   end

    #   if user.role == "admin"

    #   end
    # end

  end
end
