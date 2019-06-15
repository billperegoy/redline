defmodule Redline.Repo do
  use Ecto.Repo,
    otp_app: :redline,
    adapter: Ecto.Adapters.Postgres
end
