defmodule CryptoApis.BitstampTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Bitstamp
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitstamp.order_book(:BTCGBP)
        assert response.status_code == 200
        assert response.request_url == "https://www.bitstamp.net/api/v2/order_book/btcgbp/"
      end
    end
  end

  describe "ticker" do
    test "ticker/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitstamp.ticker("BTCGBP")
        assert response.status_code == 200
        assert response.request_url == "https://www.bitstamp.net/api/v2/ticker/btcgbp/"
      end
    end
  end

  describe "hourly_ticker" do
    test "hourly_ticker/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitstamp.hourly_ticker("BTCGBP")
        assert response.status_code == 200
        assert response.request_url == "https://www.bitstamp.net/api/v2/ticker_hour/btcgbp/"
      end
    end
  end

  describe "trades" do
    test "trades/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitstamp.trades({:BTC, "GBP"})
        assert response.status_code == 200
        assert response.request_url == "https://www.bitstamp.net/api/v2/transactions/btcgbp/"
      end
    end
  end

  describe "ohlc" do
    test "ohlc/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitstamp.ohlc({:BTC, "GBP"})
        assert response.status_code == 200
        assert response.request_url == "https://www.bitstamp.net/api/v2/ohlc/btcgbp/"
        assert response.request.options == [params: [limit: 100, step: 60]]
      end
    end

    test "ohlc/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} =
                 Bitstamp.ohlc({:BTC, "GBP"}, start: "start", end: "end", step: 30, limit: 1)

        assert response.status_code == 200
        assert response.request_url == "https://www.bitstamp.net/api/v2/ohlc/btcgbp/"

        assert response.request.options == [
                 params: [start: "start", end: "end", step: 30, limit: 1]
               ]
      end
    end
  end

  describe "pairs" do
    test "pairs/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitstamp.pairs()
        assert response.status_code == 200
        assert response.request_url == "https://www.bitstamp.net/api/v2/trading-pairs-info/"
      end
    end
  end
end
