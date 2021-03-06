defmodule CryptoApis.NairaexTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.Nairaex
  import CryptoApis.Fixtures

  describe "rates" do
    test "rates/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = Nairaex.rates()
        assert response.status_code == 200
        assert response.request_url == "https://nairaex.com/api/rates"
      end
    end
  end
end
