defmodule CryptoApis.BinanceTest do
  use ExUnit.Case

  alias CryptoApis.Binance
  import Mox

  setup :verify_on_exit!

  describe "futures v1" do
    test "get_futures/0" do
      expect(
        CryptoApis.HTTPClient.Mock,
        :get,
        2,
        fn "https://fapi.binance.com/fapi/v1/premiumIndex", [], [] ->
          {:ok, %HTTPoison.Response{status_code: 200}}
        end
      )

      assert {:ok, _response} = Binance.Futures.get_futures()
      assert {:ok, _response} = Binance.Futures.V1.get_futures()
    end

    test "get_future/1" do
      expect(
        CryptoApis.HTTPClient.Mock,
        :get,
        2,
        fn "https://fapi.binance.com/fapi/v1/premiumIndex", [], [params: [symbol: "BTCDOGE"]] ->
          {:ok, %HTTPoison.Response{status_code: 200}}
        end
      )

      assert {:ok, _response} = Binance.Futures.get_future("BTCDOGE")
      assert {:ok, _response} = Binance.Futures.V1.get_future("BTCDOGE")
    end

    test "get_funding_rate/1" do
      expect(
        CryptoApis.HTTPClient.Mock,
        :get,
        2,
        fn "https://fapi.binance.com/fapi/v1/fundingRate", [], [params: [a: :b]] ->
          {:ok, %HTTPoison.Response{status_code: 200}}
        end
      )

      assert {:ok, _response} = Binance.Futures.get_funding_rate(a: :b)
      assert {:ok, _response} = Binance.Futures.V1.get_funding_rate(a: :b)
    end

    test "get_exchange_info/0" do
      expect(
        CryptoApis.HTTPClient.Mock,
        :get,
        2,
        fn "https://fapi.binance.com/fapi/v1/exchangeInfo", [], [] ->
          {:ok, %HTTPoison.Response{status_code: 200}}
        end
      )

      assert {:ok, _response} = Binance.Futures.get_exchange_info()
      assert {:ok, _response} = Binance.Futures.V1.get_exchange_info()
    end

    test "get_income_history/2 - no timestamp" do
      expect(CryptoApis.HTTPClient.Mock, :get, fn "https://fapi.binance.com/fapi/v1/income",
                                                  [{"X-MBX-APIKEY", "key"}],
                                                  [params: params] ->
        assert CryptoApis.hmac("secret", "timestamp=#{params[:timestamp]}") == params[:signature]

        {:ok, %HTTPoison.Response{status_code: 200}}
      end)

      assert {:ok, _response} = Binance.Futures.get_income_history("key", "secret")
    end

    test "get_income_history/3 - timestamp" do
      timestamp = 1_664_271_430_093

      expect(CryptoApis.HTTPClient.Mock, :get, fn "https://fapi.binance.com/fapi/v1/income",
                                                  [{"X-MBX-APIKEY", "key"}],
                                                  [params: params] ->
        assert CryptoApis.hmac("secret", "a=b&timestamp=#{timestamp}") == params[:signature]

        {:ok, %HTTPoison.Response{status_code: 200}}
      end)

      assert {:ok, _response} =
               Binance.Futures.get_income_history("key", "secret",
                 a: :b,
                 timestamp: timestamp
               )
    end
  end

  describe "futures v2" do
    test "get_current_positions/2 - without timestamp" do
      expect(CryptoApis.HTTPClient.Mock, :get, fn "https://fapi.binance.com/fapi/v2/positionRisk",
                                                  [{"X-MBX-APIKEY", "key"}],
                                                  [params: params] ->
        assert CryptoApis.hmac("secret", "timestamp=#{params[:timestamp]}") == params[:signature]

        {:ok, %HTTPoison.Response{status_code: 200}}
      end)

      assert {:ok, _response} = Binance.Futures.V2.get_current_positions("key", "secret")
    end

    test "get_current_positions/3 - with timestamp" do
      timestamp = 1_664_271_430_093

      expect(CryptoApis.HTTPClient.Mock, :get, fn "https://fapi.binance.com/fapi/v2/positionRisk",
                                                  [{"X-MBX-APIKEY", "key"}],
                                                  [params: params] ->
        assert CryptoApis.hmac("secret", "a=b&timestamp=#{timestamp}") == params[:signature]

        {:ok, %HTTPoison.Response{status_code: 200}}
      end)

      assert {:ok, _response} =
               Binance.Futures.V2.get_current_positions("key", "secret",
                 a: :b,
                 timestamp: timestamp
               )
    end
  end

  describe "p2p" do
    test "p2p_prices/3" do
      expect(
        CryptoApis.HTTPClient.Mock,
        :post,
        fn "https://p2p.binance.com/bapi/c2c/v2/friendly/c2c/adv/search",
           payload,
           [{"content-type", "application/json"}],
           [] ->
          assert Jason.decode!(payload) == %{
                   "asset" => "BTC",
                   "fiat" => "EUR",
                   "page" => 1,
                   "payTypes" => [],
                   "publisherType" => nil,
                   "rows" => 20,
                   "tradeType" => "BUY"
                 }

          {:ok, %HTTPoison.Response{status_code: 200}}
        end
      )

      assert {:ok, _response} = Binance.p2p_prices("BTCEUR")
    end
  end
end
