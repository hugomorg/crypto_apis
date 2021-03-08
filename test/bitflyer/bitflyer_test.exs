defmodule CryptoApis.BitflyerTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Bitflyer
  import CryptoApis.Fixtures

  describe "chats" do
    test "chats/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitflyer.chats(from_date: "test")
        assert response.status_code == 200
        assert response.request_url == "https://api.bitflyer.com/v1/getchats"
        assert response.request.options == [params: [from_date: "test"]]
      end
    end
  end

  describe "markets" do
    test "markets/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitflyer.markets()
        assert response.status_code == 200
        assert response.request_url == "https://api.bitflyer.com/v1/markets"
      end
    end
  end

  describe "order_book_status" do
    test "order_book_status/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitflyer.order_book_status()
        assert response.status_code == 200
        assert response.request_url == "https://api.bitflyer.com/v1/getboardstate"
      end
    end
  end

  describe "exchange_status" do
    test "exchange_status/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitflyer.exchange_status()
        assert response.status_code == 200
        assert response.request_url == "https://api.bitflyer.com/v1/gethealth"
      end
    end
  end

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
    test "trades/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Bitflyer.trades({:BTC, "JPY"}, count: 1, before: 2, after: 3)
        assert response.status_code == 200
        assert response.request_url == "https://api.bitflyer.com/v1/executions"

        assert response.request.options == [
                 params: [count: 1, before: 2, after: 3, product_code: "BTC_JPY"]
               ]
      end
    end
  end
end
