class ClientOrdersHistoryQuery < ApplicationQuery
  queries Order

  private

  def query
    relation.where(client: client)
  end

  def client
    options.fetch(:client)
  end
end
