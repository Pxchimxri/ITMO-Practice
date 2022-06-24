class LookingForCarOrdersQuery < ApplicationQuery
  queries Order

  private

  def query
    relation.looking_for_car.where(client: User.where(active: true))
  end
end
