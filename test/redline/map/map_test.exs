defmodule Redline.MapTest do
  use Redline.DataCase
  import Redline.Factory
  import Redline.TestSupport
  alias Redline.{Map, Result}
  alias Map.{Junction, Region, Trail}

  describe "junctions" do
    test "create without latitude and longitude" do
      attrs = %{name: "Junction Name"}
      {:ok, junction} = Map.create_junction(attrs)

      assert junction ==
               %Junction{
                 name: attrs.name,
                 latitude: nil,
                 longitude: nil
               }
               |> with_metadata(junction)
    end

    test "create with latitude and longitude" do
      attrs = %{name: "Junction Name", latitude: 42.5, longitude: -71.0}
      {:ok, junction} = Map.create_junction(attrs)

      assert junction ==
               %Junction{
                 name: attrs.name,
                 latitude: attrs.latitude,
                 longitude: attrs.longitude
               }
               |> with_metadata(junction)
    end

    test "create with missing required attributes" do
      attrs = %{}
      {:error, %Ecto.Changeset{valid?: valid?, errors: errors}} = Map.create_junction(attrs)

      refute valid?
      assert Enum.count(errors) == 1
      assert Keyword.fetch!(errors, :name) == {"can't be blank", [validation: :required]}
    end
  end

  describe "trail segments" do
    test "list trail segments uses order attribute" do
      junction = insert(:junction)

      middle_segment =
        insert(:trail_segment, start_id: junction.id, end_id: junction.id, order: 2)

      first_segment = insert(:trail_segment, start_id: junction.id, end_id: junction.id, order: 1)

      last_segment = insert(:trail_segment, start_id: junction.id, end_id: junction.id, order: 3)

      segment_ids =
        Map.list_trail_segments()
        |> Enum.map(& &1.id)

      assert segment_ids == [first_segment.id, middle_segment.id, last_segment.id]
    end

    test "create with valid junctions" do
      start_junction = insert(:junction, name: "Start Junction")
      end_junction = insert(:junction, name: "End Junction")

      {:ok, trail_segment} = Map.create_trail_segment(start_junction, end_junction, 10)

      assert trail_segment.start_id == start_junction.id
      assert trail_segment.end_id == end_junction.id
    end
  end

  describe "trails" do
    test "list trails" do
      insert(:trail, name: "first")
      insert(:trail, name: "third")
      insert(:trail, name: "second")

      trail_names =
        Map.list_trails()
        |> Enum.map(& &1.name)

      assert trail_names == ["first", "second", "third"]
    end

    test "create with valid attributes and no segments" do
      attrs = %{name: "Trail Name"}

      {:ok, trail} =
        attrs
        |> Map.create_trail()
        |> Result.map(&Repo.preload(&1, :trail_segments))

      assert trail ==
               %Trail{
                 name: attrs.name,
                 trail_segments: []
               }
               |> with_metadata(trail)
    end

    test "create with missing required attributes" do
      attrs = %{}
      {:error, %Ecto.Changeset{valid?: valid?, errors: errors}} = Map.create_trail(attrs)

      refute valid?
      assert Enum.count(errors) == 1
      assert Keyword.fetch!(errors, :name) == {"can't be blank", [validation: :required]}
    end

    test "create valid trail with segments" do
      segment_1 = insert(:trail_segment)
      segment_2 = insert(:trail_segment)

      attrs = %{name: "Trail Name"}

      {:ok, trail} =
        attrs
        |> Map.create_trail([segment_1, segment_2])
        |> Result.map(&Repo.preload(&1, :trail_segments))

      expected_segment_ids = [segment_1.id, segment_2.id]
      assert trail.trail_segments |> Enum.map(& &1.id) == expected_segment_ids
    end
  end

  describe "regions" do
    test "list regions" do
      insert(:region, name: "first")
      insert(:region, name: "third")
      insert(:region, name: "second")

      region_names =
        Map.list_regions()
        |> Enum.map(& &1.name)

      assert region_names == ["first", "second", "third"]
    end

    test "create with valid attributes" do
      {:ok, region} = Map.create_region(%{name: "region"})

      assert region ==
               %Region{name: "region"}
               |> with_metadata(region)
    end
  end
end
