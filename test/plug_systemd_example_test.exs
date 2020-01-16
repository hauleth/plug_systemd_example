defmodule PlugSystemdExampleTest do
  use ExUnit.Case
  doctest PlugSystemdExample

  test "greets the world" do
    assert PlugSystemdExample.hello() == :world
  end
end
