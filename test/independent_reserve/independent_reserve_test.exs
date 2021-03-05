defmodule CryptoApis.IndependentReserveTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.IndependentReserve
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.order_book(:BTCAUS)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetOrderBook"

        assert response.request.options == [
                 params: [primaryCurrencyCode: "xbt", secondaryCurrencyCode: "aus"]
               ]
      end
    end
  end
end
