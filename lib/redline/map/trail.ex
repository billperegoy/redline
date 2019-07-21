defmodule Redline.Map.Trail do
  @moduledoc """
  Model definition for Trail
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Redline.Map.{Region, TrailSegment}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "trails" do
    field :name, :string

    belongs_to(:region, Region)
    has_many(:trail_segments, TrailSegment)
    timestamps()
  end

  @doc false
  def changeset(trail, attrs) do
    trail
    |> cast(attrs, required_attrs() ++ optional_attrs)
    |> validate_required(required_attrs())
  end

  def required_attrs, do: [:name]
  def optional_attrs, do: [:region_id]
end
