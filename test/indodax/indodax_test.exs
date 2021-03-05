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
end
