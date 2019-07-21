defmodule Redline.Map do
  import Ecto.Query, warn: false
  alias Redline.Map.{Junction, Region, Trail, TrailSegment}
  alias Redline.Repo

  def create_junction(attrs) do
    %Junction{}
    |> Junction.changeset(attrs)
    |> Repo.insert()
  end

  def list_trail_segments() do
    from(segment in TrailSegment, order_by: segment.order)
    |> Repo.all()
  end

  def create_trail_segment(
        %Junction{id: start_id},
        %Junction{id: end_id},
        order
      ) do
    attrs = %{start_id: start_id, end_id: end_id, order: order}

    %TrailSegment{}
    |> TrailSegment.changeset(attrs)
    |> Repo.insert()
  end

  def create_trail(attrs) do
    %Trail{}
    |> Trail.changeset(attrs)
    |> Repo.insert()
  end

  def create_trail(attrs, segments) do
    with {:ok, trail} <-
           %Trail{}
           |> Trail.changeset(attrs)
           |> Repo.insert() do
      Enum.each(segments, fn segment ->
        segment
        |> TrailSegment.add_to_trail_changeset(%{trail_id: trail.id})
        |> Repo.update()
      end)

      {:ok, trail}
    end
  end

  def list_trails() do
    from(trail in Trail, order_by: trail.name)
    |> Repo.all()
  end

  def list_regions() do
    from(region in Region, order_by: region.name)
    |> Repo.all()
  end

  def create_region(attrs) do
    %Region{}
    |> Region.changeset(attrs)
    |> Repo.insert()
  end
end
