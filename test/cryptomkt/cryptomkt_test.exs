defmodule CryptoApis.CryptomktTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Cryptomkt
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Cryptomkt.order_book(:BTCARS)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.exchange.cryptomkt.com/api/3/public/orderbook/BTCARS"
      end
    end
  end

  describe "ticker" do
    test "ticker/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Cryptomkt.ticker("BTCARS")
        assert response.status_code == 200
        assert response.request_url == "https://api.exchange.cryptomkt.com/api/3/public/ticker"
        assert response.request.options == [params: [symbols: "BTCARS"]]
      end
    end
  end
end
