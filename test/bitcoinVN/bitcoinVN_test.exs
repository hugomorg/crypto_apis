defmodule CryptoApis.BitcoinVNTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.BitcoinVN
  import CryptoApis.Fixtures

  describe "prices" do
    test "prices/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = BitcoinVN.prices()
        assert response.status_code == 200
        assert response.request_url == "https://api.bitcoinvn.io/api/prices"
      end
    end
  end

  describe "history" do
    test "history/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = BitcoinVN.history()
        assert response.status_code == 200
        assert response.request_url == "https://api.bitcoinvn.io/api/history"
      end
    end
  end

  describe "volume" do
    test "volume/3 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, _options ->
          {:ok, successful_response(url: url)}
        end do
        assert {:ok, response} = BitcoinVN.volume("VND", "24h")
        assert response.status_code == 200
        assert response.request_url == "https://api.bitcoinvn.io/api/volume/VND/24h"
      end
    end
  end
end
