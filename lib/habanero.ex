defmodule Habanero do
  @external_resource "README.md"
  @moduledoc @external_resource
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  @doc """
  Hello world.

  ## Examples

      iex> Habanero.hello()
      :world

  """
  def hello do
    :world
  end
end
