defmodule HabaneroTest do
  use ExUnit.Case
  doctest Habanero

  test "greets the world" do
    assert Habanero.hello() == :world
  end
end
