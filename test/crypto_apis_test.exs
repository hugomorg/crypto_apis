defmodule CryptoApisTest do
  use ExUnit.Case
  doctest CryptoApis
  import Mock
  import CryptoApis.Fixtures

  @data %{key: :value}
  @encoded Jason.encode!(@data)
  @decoded Jason.decode!(@encoded)
  @url "http://localhost:4000"
  @json_headers [{"Content-Type", "application/json"}]

  describe "get/2" do
    test "collects params from top-level" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(body: @encoded, url: url, options: options)}
        end do
        assert {:ok, response} = CryptoApis.get(@url, params: [key: :value])
        assert response.request.options == [params: [key: :value]]
      end
    end

    test "get returns successful non-json responses" do
      with_mock HTTPoison,
        get: fn _url, _headers, _options ->
          {:ok, successful_response(body: @encoded)}
        end do
        assert {:ok, response} = CryptoApis.get(@url)
        assert response.body == @encoded
        assert response.status_code == 200
      end
    end

    test "get returns successful json responses" do
      with_mock HTTPoison,
        get: fn _url, _headers, _options ->
          {:ok, successful_response(headers: @json_headers, body: @encoded)}
        end do
        assert {:ok, response} = CryptoApis.get(@url)
        assert response.body == @decoded
        assert response.request.headers == @json_headers
        assert response.status_code == 200
      end
    end

    test "get returns error responses for any error status code outside 200-300" do
      with_mock HTTPoison,
        get: fn _url, _headers, _options ->
          {:error, error_response()}
        end do
        assert CryptoApis.get(@url) ==
                 {:error,
                  %HTTPoison.Response{
                    status_code: 404
                  }}

        assert {:error, response} = CryptoApis.get(@url)
        assert response.status_code == 404
      end
    end

    test "get returns error responses for json error" do
      with_mock HTTPoison,
        get: fn _url, _headers, _options ->
          {:ok, successful_response(headers: @json_headers, body: "bad json")}
        end do
        assert {:error, %Jason.DecodeError{}} = CryptoApis.get(@url)
      end
    end
  end

  describe "data/2" do
    test "data returns successful non-json responses" do
      with_mock HTTPoison,
        get: fn _url, _headers, _options ->
          {:ok, successful_response(body: @encoded)}
        end do
        assert {:ok, response} = CryptoApis.data(@url)
        assert response == @encoded
      end
    end

    test "data returns successful json responses" do
      with_mock HTTPoison,
        get: fn _url, _headers, _options ->
          {:ok, successful_response(headers: @json_headers, body: @encoded)}
        end do
        assert {:ok, response} = CryptoApis.data(@url)
        assert response == @decoded
      end
    end
  end
end
