defmodule CryptoApis.IndodaxTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Indodax
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Indodax.order_book(:BTCIDR)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://indodax.com/api/depth/btcidr"
      end
    end
  end

  describe "trades" do
    test "trades/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Indodax.trades(:BTCIDR)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://indodax.com/api/trades/btcidr"
      end
    end
  end

  describe "ticker" do
    test "ticker/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Indodax.ticker(:BTCIDR)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://indodax.com/api/ticker/btcidr"
      end
    end
  end

  describe "ticker_all" do
    test "ticker_all/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Indodax.ticker_all()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://indodax.com/api/ticker_all"
      end
    end
  end

  describe "server_time" do
    test "server_time/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Indodax.server_time()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://indodax.com/api/server_time/"
      end
    end
  end

  describe "pairs" do
    test "pairs/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Indodax.pairs()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://indodax.com/api/pairs/"
      end
    end
  end

  describe "price_increments" do
    test "price_increments/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Indodax.price_increments()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://indodax.com/api/price_increments/"
      end
    end
  end

  describe "summaries" do
    test "summaries/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Indodax.summaries()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://indodax.com/api/summaries/"
      end
    end
  end
end
