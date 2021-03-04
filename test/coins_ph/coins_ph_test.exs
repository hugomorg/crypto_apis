defmodule CryptoApis.CoinsPHTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.CoinsPH
  import CryptoApis.Fixtures

  describe "rates" do
    test "rates/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = CoinsPH.rates()
        assert response.status_code == 200
        assert response.request_url == "https://quote.coins.ph/v2/markets"
      end
    end

    test "rates/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = CoinsPH.rates(:BTCPHP)
        assert response.status_code == 200
        assert response.request_url == "https://quote.coins.ph/v2/markets/BTC-PHP"
      end
    end

    test "rates/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = CoinsPH.rates({"BTC", :THB}, "TH")
        assert response.status_code == 200
        assert response.request_url == "https://quote.coins.ph/v2/markets/BTC-THB"
        assert response.request.options == [params: [region: "TH"]]
      end
    end
  end
end
