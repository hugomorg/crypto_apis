defmodule CryptoApis.CoinbaseTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Coinbase
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/1 responds ok" do
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
    test "trades/3 responds ok" do
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
end
