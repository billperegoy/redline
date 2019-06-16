defmodule Redline.Result do
  def map({:ok, result}, f) do
    {:ok, f.(result)}
  end

  def map({:error, error}, _f) do
    {:error, error}
  end
end
