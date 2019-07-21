defmodule Redline.Factory do
  @moduledoc """
  Test factories for `Redline`
  """

  use ExMachina.Ecto, repo: Redline.Repo

  alias Redline.Map

  def junction_factory do
    %Map.Junction{
      name: "Junction Name",
      latitude: nil,
      longitude: nil
    }
  end

  def junction_with_location_factory do
    struct!(
      junction_factory(),
      %{
        latitude: 42.5,
        longitude: -71.0
      }
    )
  end

  def trail_segment_factory do
    %Map.TrailSegment{}
  end

  def trail_factory do
    %Map.Trail{}
  end

  def region_factory do
    %Map.Region{}
  end
end
