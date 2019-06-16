defmodule Redline.Repo.Migrations.CreateTrailSegments do
  use Ecto.Migration

  def change do
    create table(:trail_segments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :start_id, references(:junctions, type: :binary_id)
      add :end_id, references(:junctions, type: :binary_id)
      add :trail_id, references(:trails, type: :binary_id)
      add :order, :integer

      timestamps()
    end

    create index(:trail_segments, [:start_id])
    create index(:trail_segments, [:end_id])
  end
end
