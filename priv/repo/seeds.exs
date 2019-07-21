# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
alias Redline.Map

{:ok, washington_region} = Map.create_region(%{name: "Mt. Washington and the Southern Ridges"})
{:ok, moosilauke_region} = Map.create_region(%{name: "The Moosilauke Region"})

{:ok, j1} = Map.create_junction(%{name: "Pinkam Notch Visitor Center"})
{:ok, j2} = Map.create_junction(%{name: "Boott Spur Trail"})
{:ok, j3} = Map.create_junction(%{name: "Huntington Ravine Trail"})
{:ok, j4} = Map.create_junction(%{name: "Huntington Ravine Fire Road"})
{:ok, j5} = Map.create_junction(%{name: "Lion Head Trail"})
{:ok, j6} = Map.create_junction(%{name: "Boot Spur Link and Hermit Lake Shelters"})
{:ok, j7} = Map.create_junction(%{name: "Snow Arch"})
{:ok, j8} = Map.create_junction(%{name: "Alpine Garden Trail"})
{:ok, j9} = Map.create_junction(%{name: "Tuckerman junction"})
{:ok, j10} = Map.create_junction(%{name: "Lion Head Trail, upper junction"})
{:ok, j11} = Map.create_junction(%{name: "Mt. Washington summit"})

segments =
  [
    Map.create_trail_segment(j1, j2, 1),
    Map.create_trail_segment(j2, j3, 2),
    Map.create_trail_segment(j3, j4, 3),
    Map.create_trail_segment(j4, j5, 4),
    Map.create_trail_segment(j5, j6, 5),
    Map.create_trail_segment(j6, j7, 6),
    Map.create_trail_segment(j7, j8, 7),
    Map.create_trail_segment(j8, j9, 8),
    Map.create_trail_segment(j9, j10, 9),
    Map.create_trail_segment(j10, j11, 10)
  ]
  |> Enum.map(fn {:ok, segment} -> segment end)

{:ok, tuckerman_ravine} =
  Map.create_trail(%{name: "Tuckerman Ravine Trail", region_id: washington_region.id}, segments)

{:ok, j12} = Map.create_junction(%{name: "Alpine Garden Trail"})

segments =
  [
    Map.create_trail_segment(j5, j12, 1),
    Map.create_trail_segment(j12, j10, 2)
  ]
  |> Enum.map(fn {:ok, segment} -> segment end)

{:ok, lion_head} =
  Map.create_trail(%{name: "Lion Head Trail", region_id: washington_region.id}, segments)

{:ok, j13} = Map.create_junction(%{name: "NH 112"})
{:ok, j14} = Map.create_junction(%{name: "Beaver Brook Shelter"})
{:ok, j15} = Map.create_junction(%{name: "Asquam Ridge Trail"})
{:ok, j16} = Map.create_junction(%{name: "Benton Traill"})
{:ok, j17} = Map.create_junction(%{name: "Mt. Moosilauke summit"})

segments =
  [
    Map.create_trail_segment(j13, j14, 1),
    Map.create_trail_segment(j14, j15, 2),
    Map.create_trail_segment(j15, j16, 3),
    Map.create_trail_segment(j16, j17, 4)
  ]
  |> Enum.map(fn {:ok, segment} -> segment end)

Map.create_trail(%{name: "Beaver Brook Trail", region_id: moosilauke_region.id}, segments)

{:ok, j18} = Map.create_junction(%{name: "Little Tunnel Ravine outlook"})
{:ok, j19} = Map.create_junction(%{name: "Tunnel Brook Rd."})
{:ok, j20} = Map.create_junction(%{name: "Beaver Brook Trail junction"})

segments =
  [
    Map.create_trail_segment(j18, j19, 1),
    Map.create_trail_segment(j19, j20, 2),
    Map.create_trail_segment(j19, j17, 2)
  ]
  |> Enum.map(fn {:ok, segment} -> segment end)

Map.create_trail(%{name: "Benton Trail", region_id: moosilauke_region.id}, segments)
