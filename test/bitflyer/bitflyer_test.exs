defmodule CryptoApis.BitflyerTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Bitflyer
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitflyer.order_book(:BTCJPY)
        assert response.status_code == 200
        assert response.request_url == "https://api.bitflyer.com/v1/board"
        assert response.request.options == [params: [product_code: "BTC_JPY"]]
      end
    end
  end

  describe "ticker" do
    test "ticker/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitflyer.ticker("BTCJPY")
        assert response.status_code == 200
        assert response.request_url == "https://api.bitflyer.com/v1/ticker"
        assert response.request.options == [params: [product_code: "BTC_JPY"]]
      end
    end
  end

  describe "trades" do
    test "trades/3 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitflyer.trades({:BTC, "JPY"})
        assert response.status_code == 200
        assert response.request_url == "https://api.bitflyer.com/v1/executions"
        assert response.request.options == [params: [product_code: "BTC_JPY"]]
      end
    end
  end
end
