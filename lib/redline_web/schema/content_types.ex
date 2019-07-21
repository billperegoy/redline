defmodule RedlineWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  object :region do
    field :id, :id
    field :name, :string
  end
end
