defmodule CryptoApis.FTXTest do
  use ExUnit.Case

  alias CryptoApis.FTX
  alias CryptoApis.HTTPClient
  import Mox

  setup :verify_on_exit!

  describe "Futures" do
    test "get_futures/0" do
      expect(HTTPClient.Mock, :get, fn url, [], [] ->
        assert url == "https://ftx.com/api/futures"
        {:ok, %HTTPoison.Response{status_code: 200}}
      end)

      assert {:ok, _} = FTX.Futures.get_futures()
    end

    test "get_future/1" do
      expect(HTTPClient.Mock, :get, fn url, [], [] ->
        assert url == "https://ftx.com/api/futures/VETUSDT"
        {:ok, %HTTPoison.Response{status_code: 200}}
      end)

      assert {:ok, _} = FTX.Futures.get_future("VETUSDT")
    end

    test "get_funding_rates/1" do
      expect(HTTPClient.Mock, :get, fn url, [], [params: [a: :b]] ->
        assert url == "https://ftx.com/api/funding_rates"
        {:ok, %HTTPoison.Response{status_code: 200}}
      end)

      assert {:ok, _} = FTX.Futures.get_funding_rates(a: :b)
    end

    test "get_funding_rate/1" do
      expect(HTTPClient.Mock, :get, fn url, [], opts ->
        assert url == "https://ftx.com/api/funding_rates"
        assert opts[:params][:future] == "VETUSDT"
        {:ok, %HTTPoison.Response{status_code: 200}}
      end)

      assert {:ok, _} = FTX.Futures.get_funding_rate("VETUSDT")
    end

    test "get_current_positions/3" do
      expect(HTTPClient.Mock, :get, fn url, headers, opts ->
        assert url == "https://ftx.com/api/positions"

        assert headers == [
                 {"FTX-KEY", "key"},
                 {"FTX-TS", 1_666_354_178_859},
                 {"FTX-SIGN", "00b5c7267b80e39d89ba947ed49cf030ffd171a883610df32c8a2ad10eee6ffb"}
               ]

        assert opts[:params][:timestamp] == 1_666_354_178_859
        {:ok, %HTTPoison.Response{status_code: 200}}
      end)

      timestamp = 1_666_354_178_859

      assert {:ok, _} = FTX.Futures.get_current_positions("key", "secret", timestamp: timestamp)
    end

    test "get_current_positions/2 - timestamp added automatically" do
      expect(HTTPClient.Mock, :get, fn url, headers, [] ->
        assert url == "https://ftx.com/api/positions"
        assert [{"FTX-KEY", "key"}, {"FTX-TS", timestamp}, {"FTX-SIGN", signature}] = headers
        assert is_integer(timestamp)
        assert is_binary(signature)

        {:ok, %HTTPoison.Response{status_code: 200}}
      end)

      assert {:ok, _} = FTX.Futures.get_current_positions("key", "secret")
    end
  end
end
