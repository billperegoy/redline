defmodule Redline.TestSupport do
  def with_metadata(expected, actual) do
    %{
      expected
      | inserted_at: actual.inserted_at,
        updated_at: actual.updated_at,
        id: actual.id,
        __meta__: actual.__meta__
    }
  end
end
