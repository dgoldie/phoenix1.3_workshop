defmodule RomanNumeralServicesTest do
  use ExUnit.Case
  doctest RomanNumeralServices

  test "greets the world" do
    assert RomanNumeralServices.hello() == :world
  end
end
