defmodule Redline.Repo.Migrations.CreateJunctions do
  use Ecto.Migration

  def change do
    create table(:junctions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :latitude, :float
      add :longitude, :float

      timestamps()
    end
  end
end
