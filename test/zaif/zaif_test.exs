defmodule CryptoApis.ZaifTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Zaif
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Zaif.order_book(:BTCJPY)
        assert response.status_code == 200
        assert response.request_url == "https://api.zaif.jp/api/1/depth/btc_jpy"
      end
    end
  end

  describe "ticker" do
    test "ticker/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Zaif.ticker("BTCJPY")
        assert response.status_code == 200
        assert response.request_url == "https://api.zaif.jp/api/1/ticker/btc_jpy"
      end
    end
  end

  describe "trades" do
    test "trades/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Zaif.trades({:BTC, "JPY"})
        assert response.status_code == 200
        assert response.request_url == "https://api.zaif.jp/api/1/trades/btc_jpy"
      end
    end
  end

  describe "currency_info" do
    test "currency_info/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Zaif.currency_info(:BTC)
        assert response.status_code == 200
        assert response.request_url == "https://api.zaif.jp/api/1/currencies/btc"
      end
    end
  end

  describe "pair_info" do
    test "pair_info/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Zaif.pair_info(:BTCJPY)
        assert response.status_code == 200
        assert response.request_url == "https://api.zaif.jp/api/1/currency_pairs/btc_jpy"
      end
    end
  end

  describe "last_price" do
    test "last_price/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Zaif.last_price(:BTCJPY)
        assert response.status_code == 200
        assert response.request_url == "https://api.zaif.jp/api/1/last_price/btc_jpy"
      end
    end
  end
end
