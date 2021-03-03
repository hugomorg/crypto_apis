defmodule CryptoApis.UtilsTest do
  use ExUnit.Case

  describe "split_pair/1" do
    test "splits pair into crypto and fiat" do
      assert CryptoApis.Utils.split_pair("BTCJPY") == {"BTC", "JPY"}
      assert CryptoApis.Utils.split_pair(:USDTGBP) == {"USDT", "GBP"}
    end
  end
end