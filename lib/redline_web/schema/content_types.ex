defmodule RedlineWeb.Schema.ContentTypes do
  @moduledoc """
  Top level type definitions for GraphQL
  """

  use Absinthe.Schema.Notation

  object :region do
    field :id, :id
    field :name, :string
  end
end
