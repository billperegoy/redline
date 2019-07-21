defmodule RedlineWeb.Schema do
  @moduledoc """
  GraphQL query type definitions
  """

  use Absinthe.Schema
  import_types(RedlineWeb.Schema.ContentTypes)

  query do
    @desc "Get all regions"
    field :regions, list_of(:region) do
      resolve(&list_regions/3)
    end
  end

  def list_regions(_parent, _args, _resolution) do
    {:ok, Redline.Map.list_regions()}
  end
end
