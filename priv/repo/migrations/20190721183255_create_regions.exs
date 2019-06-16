defmodule Redline.Repo.Migrations.CreateRegions do
  use Ecto.Migration

  def change do
    create table(:regions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps()
    end

    alter table(:trails) do
      add :region_id, references(:regions, type: :binary_id)
    end
  end
end
