defmodule CryptoApis.UtilsTest do
  use ExUnit.Case

  describe "split_pair/1" do
    test "splits pair into crypto and fiat" do
      assert CryptoApis.Utils.split_pair("BTCJPY") == {"BTC", "JPY"}
      assert CryptoApis.Utils.split_pair(:USDTGBP) == {"USDT", "GBP"}
    end
  end

  describe "override_params/3" do
    test "overrides params key with value" do
      original = [params: [key: :value]]

      assert CryptoApis.Utils.override_params(original, :key, :new_value) == [
               params: [key: :new_value]
             ]
    end
  end
end
