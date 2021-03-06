defmodule CryptoApis.RemitanoTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Remitano
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Remitano.order_book(:BTCVND)
        assert response.status_code == 200
        assert response.request_url == "https://api.remitano.com/api/v1/markets/BTCVND/order_book"
      end
    end
  end

  describe "trades" do
    test "trades/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Remitano.trades("BTCVND")
        assert response.status_code == 200
        assert response.request_url == "https://api.remitano.com/api/v1/markets/BTCVND/trades"
      end
    end
  end

  describe "volume" do
    test "volume/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Remitano.volume()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.remitano.com/api/v1/volumes/market_summaries"
      end
    end
  end

  describe "currencies" do
    test "currencies/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Remitano.currencies()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.remitano.com/api/v1/currencies/info"
      end
    end
  end

  describe "markets" do
    test "markets/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Remitano.markets()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.remitano.com/api/v1/markets/info"
      end
    end
  end
end
