defmodule CryptoApis.CoinfloorTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Coinfloor
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinfloor.order_book(:BTCGBP)
        assert response.status_code == 200
        assert response.request_url == "https://webapi.coinfloor.co.uk/bist/XBT/GBP/order_book/"
      end
    end
  end

  describe "ticker" do
    test "ticker/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinfloor.ticker("BTCGBP")
        assert response.status_code == 200
        assert response.request_url == "https://webapi.coinfloor.co.uk/bist/XBT/GBP/ticker/"
      end
    end
  end

  describe "trades" do
    test "trades/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Coinfloor.trades({:BTC, "GBP"}, "minute")
        assert response.status_code == 200
        assert response.request_url == "https://webapi.coinfloor.co.uk/bist/XBT/GBP/transactions/"
        assert response.request.options == [params: [time: "minute"]]
      end
    end
  end
end
