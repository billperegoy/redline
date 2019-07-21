defmodule RedlineWeb.Router do
  use RedlineWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: RedlineWeb.Schema

    forward "/", Absinthe.Plug, schema: RedlineWeb.Schema
  end
end
