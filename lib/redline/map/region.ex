defmodule Redline.Map.Region do
  @moduledoc """
  Model definoition for Region.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Redline.Map.Trail

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "regions" do
    field :name, :string

    has_many(:trails, Trail)
    timestamps()
  end

  @doc false
  def changeset(region, attrs) do
    region
    |> cast(attrs, required_attrs())
    |> validate_required(required_attrs())
  end

  def required_attrs, do: [:name]
end
