defmodule CryptoApis.UtilsTest do
  use ExUnit.Case

  alias CryptoApis.Utils

  describe "split_pair/1" do
    test "splits pair into crypto and fiat" do
      assert Utils.split_pair("BTCJPY") == {"BTC", "JPY"}
      assert Utils.split_pair(:USDTGBP) == {"USDT", "GBP"}
    end
  end

  describe "pair_to_tuple/1" do
    test "converts from string" do
      assert Utils.pair_to_tuple("BTCJPY") == {"BTC", "JPY"}
    end

    test "converts from atom" do
      assert Utils.pair_to_tuple(:BTCJPY) == {"BTC", "JPY"}
    end
  end

  describe "pair_to_string/2" do
    test "converts from string" do
      assert Utils.pair_to_string("BTCVND") == "BTCVND"
    end

    test "converts from atom" do
      assert Utils.pair_to_string(:BTCVND) == "BTCVND"
    end

    test "converts from tuple" do
      assert Utils.pair_to_string({"BTC", "VND"}) == "BTCVND"
    end

    test "works with separator" do
      assert Utils.pair_to_string({"BTC", "VND"}, "_") == "BTC_VND"
      assert Utils.pair_to_string(:BTCGBP, ".") == "BTC.GBP"
      assert Utils.pair_to_string("BTCUSD", "-") == "BTC-USD"
    end
  end
end
