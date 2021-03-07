defmodule CryptoApis.UpbitTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Upbit
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Upbit.order_book(:BTCKRW, limit: 10)
        assert response.status_code == 200
        assert response.request_url == "https://api.upbit.com/v1/orderbook"
        assert response.request.options == [params: [markets: "KRW-BTC"]]
      end
    end
  end

  describe "markets" do
    test "markets/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Upbit.markets()
        assert response.status_code == 200
        assert response.request_url == "https://api.upbit.com/v1/market/all"
      end
    end
  end

  describe "ticker" do
    test "ticker/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Upbit.ticker(:BTCKRW)
        assert response.status_code == 200
        assert response.request_url == "https://api.upbit.com/v1/ticker"
        assert response.request.options == [params: [markets: "KRW-BTC"]]
      end
    end
  end

  describe "trades" do
    test "trades/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Upbit.trades(:BTCKRW)
        assert response.status_code == 200
        assert response.request_url == "https://api.upbit.com/v1/trades/ticks"
        assert response.request.options == [params: [market: "KRW-BTC"]]
      end
    end
  end
end
