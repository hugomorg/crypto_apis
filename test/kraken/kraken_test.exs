defmodule CryptoApis.KrakenTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Kraken
  import CryptoApis.Fixtures

  describe "url/1" do
    test "url for server time" do
      assert Kraken.url(:server_time) == "https://api.kraken.com/0/public/Time"
    end

    test "url for system status" do
      assert Kraken.url(:system_status) == "https://api.kraken.com/0/public/SystemStatus"
    end

    test "url for assets" do
      assert Kraken.url(:assets) == "https://api.kraken.com/0/public/Assets"
    end

    test "url for asset_pairs" do
      assert Kraken.url(:asset_pairs) == "https://api.kraken.com/0/public/AssetPairs"
    end

    test "url for ticker" do
      assert Kraken.url(:ticker) == "https://api.kraken.com/0/public/Ticker"
    end

    test "url for OHLC" do
      assert Kraken.url(:ohlc) == "https://api.kraken.com/0/public/OHLC"
    end

    test "url for order book" do
      assert Kraken.url(:order_book) == "https://api.kraken.com/0/public/Depth"
    end

    test "url for trades" do
      assert Kraken.url(:trades) == "https://api.kraken.com/0/public/Trades"
    end

    test "url for spread" do
      assert Kraken.url(:spread) == "https://api.kraken.com/0/public/Spread"
    end
  end

  describe "server time" do
    test "server_time/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = Kraken.server_time()
        assert response.status_code == 200
        assert response.request_url == "https://api.kraken.com/0/public/Time"
      end
    end
  end

  describe "system status" do
    test "system_status/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = Kraken.system_status()
        assert response.status_code == 200
        assert response.request_url == "https://api.kraken.com/0/public/SystemStatus"
      end
    end
  end

  describe "assets" do
    test "assets/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = Kraken.assets()
        assert response.status_code == 200
        assert response.request_url == "https://api.kraken.com/0/public/Assets"
      end
    end
  end

  describe "asset_pairs" do
    test "asset_pairs/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = Kraken.asset_pairs()
        assert response.status_code == 200
        assert response.request_url == "https://api.kraken.com/0/public/AssetPairs"
      end
    end
  end

  describe "ticker" do
    test "ticker/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Kraken.ticker(:BTCUSD)
        assert response.status_code == 200
        assert response.request_url == "https://api.kraken.com/0/public/Ticker"
        assert response.request.options == [params: [pair_name: :BTCUSD]]
      end
    end
  end

  describe "ohlc" do
    test "ohlc/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Kraken.ohlc(:BTCUSD)
        assert response.status_code == 200
        assert response.request_url == "https://api.kraken.com/0/public/OHLC"
        assert response.request.options == [params: [pair: :BTCUSD]]
      end
    end
  end

  describe "order_book" do
    test "order_book/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Kraken.order_book(:BTCUSD)
        assert response.status_code == 200
        assert response.request_url == "https://api.kraken.com/0/public/Depth"
        assert response.request.options == [params: [pair: :BTCUSD]]
      end
    end
  end

  describe "trades" do
    test "trades/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Kraken.trades(:BTCUSD)
        assert response.status_code == 200
        assert response.request_url == "https://api.kraken.com/0/public/Trades"
        assert response.request.options == [params: [pair: :BTCUSD]]
      end
    end
  end

  describe "spread" do
    test "spread/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Kraken.spread(:BTCUSD)
        assert response.status_code == 200
        assert response.request_url == "https://api.kraken.com/0/public/Spread"
        assert response.request.options == [params: [pair: :BTCUSD]]
      end
    end
  end
end
