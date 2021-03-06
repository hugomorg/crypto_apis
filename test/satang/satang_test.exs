defmodule CryptoApis.SatangTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Satang
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Satang.order_book(:BTCUSD, limit: 10)
        assert response.status_code == 200
        assert response.request_url == "https://satangcorp.com/api/v3/depth"
        assert response.request.options == [params: [limit: 10, symbol: "btc_usd"]]
      end
    end
  end

  describe "exchange_info" do
    test "exchange_info/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Satang.exchange_info()
        assert response.status_code == 200
        assert response.request_url == "https://satangcorp.com/api/v3/exchangeInfo"
      end
    end
  end

  describe "ticker" do
    test "ticker/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Satang.ticker()
        assert response.status_code == 200
        assert response.request_url == "https://satangcorp.com/api/v3/ticker/24hr"
        assert response.request.options == [params: []]
      end
    end

    test "ticker/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Satang.ticker({:BTC, "THB"})
        assert response.status_code == 200
        assert response.request_url == "https://satangcorp.com/api/v3/ticker/24hr"
        assert response.request.options == [params: [symbol: "btc_thb"]]
      end
    end
  end

  describe "aggregate_trades" do
    test "aggregate_trades/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Satang.aggregate_trades("BTCTHB")
        assert response.request_url == "https://satangcorp.com/api/v3/aggTrades"
        assert response.request.options == [params: [symbol: "btc_thb"]]
      end
    end

    test "aggregate_trades/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} =
                 Satang.aggregate_trades("BTCTHB", fromId: 2, startTime: 3, endTime: 4, limit: 5)

        assert response.request_url == "https://satangcorp.com/api/v3/aggTrades"

        assert response.request.options == [
                 params: [
                   fromId: 2,
                   startTime: 3,
                   endTime: 4,
                   limit: 5,
                   symbol: "btc_thb"
                 ]
               ]
      end
    end
  end
end
