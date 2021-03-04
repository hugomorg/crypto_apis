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
        assert {:ok, response} = Cryptomkt.order_book(:BTCARS, "buy")
        assert response.status_code == 200
        assert response.request_url == "https://api.cryptomkt.com/v1/book"
        assert response.request.options == [params: [market: :BTCARS, type: "buy"]]
      end
    end

    test "order_book/3 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Cryptomkt.order_book(:BTCARS, "buy", page: 2)
        assert response.status_code == 200
        assert response.request_url == "https://api.cryptomkt.com/v1/book"
        assert response.request.options == [params: [page: 2, market: :BTCARS, type: "buy"]]
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
        assert response.request_url == "https://api.cryptomkt.com/v1/ticker"
        assert response.request.options == [params: [market: "BTCARS"]]
      end
    end
  end

  describe "trades" do
    test "trades/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Cryptomkt.trades({:BTC, "ARS"})
        assert response.status_code == 200
        assert response.request_url == "https://api.cryptomkt.com/v1/trades"
        assert response.request.options == [params: [market: "BTCARS"]]
      end
    end

    test "trades/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        start_date = "2021-05-23"
        end_date = "2021-05-24"

        assert {:ok, response} =
                 Cryptomkt.trades({:BTC, "ARS"},
                   page: 3,
                   start: start_date,
                   end: end_date,
                   limit: 81
                 )

        assert response.status_code == 200
        assert response.request_url == "https://api.cryptomkt.com/v1/trades"

        assert response.request.options == [
                 params: [page: 3, start: start_date, end: end_date, limit: 81, market: "BTCARS"]
               ]
      end
    end
  end
end
