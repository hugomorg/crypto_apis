defmodule CryptoApis.LocalBitcoinsTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.LocalBitcoins
  import CryptoApis.Fixtures

  describe "ticker_all" do
    test "ticker_all/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = LocalBitcoins.ticker_all()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://localbitcoins.com/bitcoinaverage/ticker-all-currencies"

        assert response.request.options == [follow_redirect: true]
      end
    end
  end

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = LocalBitcoins.order_book(:VND)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://localbitcoins.com/bitcoincharts/VND/orderbook.json"
      end
    end
  end
end
