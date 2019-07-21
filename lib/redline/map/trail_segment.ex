defmodule Redline.Map.TrailSegment do
  @moduledoc """
  Mode; definition for TrailSegment
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Redline.Map.Trail

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "trail_segments" do
    field :start_id, :binary_id
    field :end_id, :binary_id
    field :order, :integer

    belongs_to :trail, Trail

    timestamps()
  end

  @doc false
  def changeset(trail_segment, attrs) do
    trail_segment
    |> cast(attrs, required_attrs())
    |> validate_required(required_attrs())
  end

  def add_to_trail_changeset(trail_segment, attrs) do
    trail_segment
    |> cast(attrs, [:trail_id])
    |> validate_required([:trail_id])
  end

  defp required_attrs, do: [:start_id, :end_id, :order]
end
