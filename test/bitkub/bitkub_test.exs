defmodule CryptoApis.BitkubTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Bitkub
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.order_book(:BTCTHB)
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/books"
        assert response.request.options == [params: [sym: "THB_BTC", lmt: 100]]
      end
    end
  end

  describe "ticker" do
    test "ticker/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.ticker("BTCTHB")
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/ticker"
        assert response.request.options == [params: [sym: "THB_BTC"]]
      end
    end
  end

  describe "trades" do
    test "trades/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.trades({:BTC, "THB"})
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/trades"
        assert response.request.options == [params: [sym: "THB_BTC", lmt: 100]]
      end
    end
  end
end
