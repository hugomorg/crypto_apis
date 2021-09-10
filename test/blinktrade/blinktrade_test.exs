defmodule CryptoApis.BlinktradeTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Blinktrade
  import CryptoApis.Fixtures

  describe "ticker" do
    test "ticker/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = Blinktrade.ticker(:BTCVND)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.blinktrade.com/api/v1/VND/ticker?crypto_currency=BTC"
      end
    end
  end

  describe "order_book" do
    test "order_book/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = Blinktrade.order_book(:BTCVND)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.blinktrade.com/api/v1/VND/orderbook?crypto_currency=BTC"
      end
    end
  end

  describe "trades" do
    test "trades/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = Blinktrade.trades(:BTCVND)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.blinktrade.com/api/v1/VND/trades?crypto_currency=BTC"
      end
    end
  end
end
