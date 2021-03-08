defmodule CryptoApis.CoinbaseTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Coinbase
  import CryptoApis.Fixtures

  describe "stats_24h" do
    test "stats_24h/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinbase.stats_24h(:BTCUSD)
        assert response.status_code == 200
        assert response.request_url == "https://api.pro.coinbase.com/products/BTC-USD/stats"
      end
    end
  end

  describe "server_time" do
    test "server_time/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinbase.server_time()
        assert response.status_code == 200
        assert response.request_url == "https://api.pro.coinbase.com/time"
      end
    end
  end

  describe "currencies" do
    test "currencies/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinbase.currencies()
        assert response.status_code == 200
        assert response.request_url == "https://api.pro.coinbase.com/currencies"
      end
    end
  end

  describe "currency" do
    test "currency/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinbase.currency(:BTC)
        assert response.status_code == 200
        assert response.request_url == "https://api.pro.coinbase.com/currencies/BTC"
      end
    end
  end

  describe "pairs" do
    test "pairs/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinbase.pairs()
        assert response.status_code == 200
        assert response.request_url == "https://api.pro.coinbase.com/products"
      end
    end
  end

  describe "pair" do
    test "pair/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinbase.pair(:BTCUSD)
        assert response.status_code == 200
        assert response.request_url == "https://api.pro.coinbase.com/products/BTC-USD"
      end
    end
  end

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinbase.order_book(:BTCUSD)
        assert response.status_code == 200
        assert response.request_url == "https://api.pro.coinbase.com/products/BTC-USD/book"
        assert response.request.options == []
      end
    end

    test "order_book/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinbase.order_book(:BTCUSD, 2)
        assert response.status_code == 200
        assert response.request_url == "https://api.pro.coinbase.com/products/BTC-USD/book"
        assert response.request.options == [params: [level: 2]]
      end
    end
  end

  describe "ticker" do
    test "ticker/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinbase.ticker("BTCUSD")
        assert response.status_code == 200
        assert response.request_url == "https://api.pro.coinbase.com/products/BTC-USD/ticker"
      end
    end
  end

  describe "trades" do
    test "trades/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinbase.trades({:BTC, "USD"})
        assert response.status_code == 200
        assert response.request_url == "https://api.pro.coinbase.com/products/BTC-USD/trades"
      end
    end
  end

  describe "historic_rates" do
    test "historic_rates/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinbase.historic_rates({:BTC, "USD"})
        assert response.status_code == 200
        assert response.request_url == "https://api.pro.coinbase.com/products/BTC-USD/candles"
      end
    end

    test "historic_rates/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} =
                 Coinbase.historic_rates({:BTC, "USD"},
                   start: "start",
                   end: "end",
                   granularity: 60
                 )

        assert response.status_code == 200
        assert response.request_url == "https://api.pro.coinbase.com/products/BTC-USD/candles"
        assert response.request.options == [params: [start: "start", end: "end", granularity: 60]]
      end
    end
  end
end
