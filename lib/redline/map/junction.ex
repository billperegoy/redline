defmodule Redline.Map.Junction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "junctions" do
    field :latitude, :float
    field :longitude, :float
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(junction, attrs) do
    junction
    |> cast(attrs, required_attrs() ++ optional_attrs())
    |> validate_required(required_attrs())
  end

  defp required_attrs(), do: [:name]
  defp optional_attrs(), do: [:latitude, :longitude]
end
