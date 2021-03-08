defmodule CryptoApis.BithumbTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Bithumb
  import CryptoApis.Fixtures

  describe "asset_status" do
    test "asset_status/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = Bithumb.asset_status(:BTC)
        assert response.status_code == 200
        assert response.request_url == "https://api.bithumb.com/public/assetsstatus/BTC"
      end
    end
  end

  describe "btci" do
    test "btci/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = Bithumb.btci()
        assert response.status_code == 200
        assert response.request_url == "https://api.bithumb.com/public/btci"
      end
    end
  end

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = Bithumb.order_book(:BTCKRW)
        assert response.status_code == 200
        assert response.request_url == "https://api.bithumb.com/public/orderbook/BTC_KRW"
      end
    end
  end

  describe "ticker" do
    test "ticker/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = Bithumb.ticker({:BTC, "KRW"})
        assert response.status_code == 200
        assert response.request_url == "https://api.bithumb.com/public/ticker/BTC_KRW"
      end
    end
  end

  describe "trades" do
    test "trades/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = Bithumb.trades(:BTCKRW)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.bithumb.com/public/transaction_history/BTC_KRW"
      end
    end
  end
end
