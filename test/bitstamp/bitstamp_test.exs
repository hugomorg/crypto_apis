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

  describe "trades" do
    test "trades/3 responds ok" do
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
end
