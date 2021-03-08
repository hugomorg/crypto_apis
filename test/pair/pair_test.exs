defmodule CryptoApis.PairTest do
  use ExUnit.Case
  alias CryptoApis.Pair

  describe "new/1" do
    test "from positions" do
      assert Pair.new(:BTC, "VND") == %Pair{crypto: "BTC", fiat: "VND"}
    end

    test "from atoms" do
      assert Pair.new(:BTCVND) == %Pair{crypto: "BTC", fiat: "VND"}
    end

    test "from strings" do
      assert Pair.new("BTCVND") == %Pair{crypto: "BTC", fiat: "VND"}
    end

    test "from maps" do
      assert Pair.new(%{"crypto" => "BTC", "fiat" => "VND"}) == %Pair{crypto: "BTC", fiat: "VND"}
      assert Pair.new(%{crypto: :BTC, fiat: :VND}) == %Pair{crypto: "BTC", fiat: "VND"}
    end

    test "from tuples" do
      assert Pair.new({"BTC", "VND"}) == %Pair{crypto: "BTC", fiat: "VND"}
    end

    test "from lists" do
      assert Pair.new(["BTC", "VND"]) == %Pair{crypto: "BTC", fiat: "VND"}
    end

    test "from keyword lists" do
      assert Pair.new(crypto: :BTC, fiat: :VND) == %Pair{crypto: "BTC", fiat: "VND"}
    end
  end

  describe "to_tuple/1" do
    test "converts to tuple" do
      pair = Pair.new(:BTC, "VND")
      assert Pair.to_tuple(pair) == {"BTC", "VND"}
    end
  end

  describe "join" do
    test "join/0 makes into string" do
      pair = Pair.new(:BTC, "VND")
      assert Pair.join(pair) == "BTCVND"
    end

    test "join/1 uses delimiter" do
      pair = Pair.new(:BTC, "VND")
      assert Pair.join(pair, "|") == "BTC|VND"
    end

    test "join/2 with options" do
      pair = Pair.new(:BTC, "VND")
      assert Pair.join(pair, "-", downcase?: true, invert?: true) == "vnd-btc"
    end
  end

  describe "implements String.Chars" do
    test "to_string" do
      pair = Pair.new(:BTC, "VND")
      assert to_string(pair) == "BTCVND"
    end
  end
end
