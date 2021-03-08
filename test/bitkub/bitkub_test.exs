defmodule CryptoApis.BitkubTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Bitkub
  import CryptoApis.Fixtures

  describe "depth" do
    test "depth/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.depth(:BTCTHB)
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/depth"
        assert response.request.options == [params: [lmt: 100, sym: "THB_BTC"]]
      end
    end

    test "depth/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.depth(:BTCTHB, 50)
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/depth"
        assert response.request.options == [params: [lmt: 50, sym: "THB_BTC"]]
      end
    end
  end

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.order_book(:BTCTHB)
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/books"
        assert response.request.options == [params: [lmt: 100, sym: "THB_BTC"]]
      end
    end

    test "order_book/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.order_book(:BTCTHB, 50)
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/books"
        assert response.request.options == [params: [lmt: 50, sym: "THB_BTC"]]
      end
    end
  end

  describe "bids" do
    test "bids/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.bids(:BTCTHB)
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/bids"
        assert response.request.options == [params: [lmt: 100, sym: "THB_BTC"]]
      end
    end

    test "bids/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.bids(:BTCTHB, 50)
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/bids"
        assert response.request.options == [params: [lmt: 50, sym: "THB_BTC"]]
      end
    end
  end

  describe "asks" do
    test "asks/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.asks(:BTCTHB)
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/asks"
        assert response.request.options == [params: [lmt: 100, sym: "THB_BTC"]]
      end
    end

    test "asks/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.asks(:BTCTHB, 50)
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/asks"
        assert response.request.options == [params: [lmt: 50, sym: "THB_BTC"]]
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

    test "ticker/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.ticker()
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/ticker"
        assert response.request.options == []
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
        assert response.request.options == [params: [lmt: 100, sym: "THB_BTC"]]
      end
    end

    test "trades/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.trades({:BTC, "THB"}, 50)
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/trades"
        assert response.request.options == [params: [lmt: 50, sym: "THB_BTC"]]
      end
    end
  end

  describe "status" do
    test "status/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.status()
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/status"
      end
    end
  end

  describe "server_time" do
    test "server_time/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.server_time()
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/servertime"
      end
    end
  end

  describe "symbols" do
    test "symbols/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitkub.symbols()
        assert response.status_code == 200
        assert response.request_url == "https://api.bitkub.com/api/market/symbols"
      end
    end
  end
end
