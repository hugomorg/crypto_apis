defmodule CryptoApisTest do
  use ExUnit.Case
  doctest CryptoApis

  test "greets the world" do
    assert CryptoApis.hello() == :world
  end
end
