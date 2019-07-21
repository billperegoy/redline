defmodule Redline.Result do
  @moduledoc """
  Functions used to process `:ok`, `:error` tuples.
  """

  def map({:ok, result}, f) do
    {:ok, f.(result)}
  end

  def map({:error, error}, _f) do
    {:error, error}
  end
end
