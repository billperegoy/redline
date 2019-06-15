defmodule RedlineWeb.Router do
  use RedlineWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RedlineWeb do
    pipe_through :api
  end
end
