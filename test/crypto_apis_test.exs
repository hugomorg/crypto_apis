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

  describe "override_params/3" do
    test "overrides params key with value" do
      original = [params: [key: :value]]
      assert CryptoApis.override_params(original, :key, :new_value) == [params: [key: :new_value]]
    end
  end

  describe "fetch/2" do
    test "collects params from top-level" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(body: @encoded, url: url, options: options)}
        end do
        assert {:ok, response} = CryptoApis.fetch(@url, params: [key: :value])
        assert response.request.options == [params: [key: :value]]
      end
    end

    test "fetch returns successful non-json responses" do
      with_mock HTTPoison,
        get: fn _url, _headers, _options ->
          {:ok, successful_response(body: @encoded)}
        end do
        assert {:ok, response} = CryptoApis.fetch(@url)
        assert response.body == @encoded
        assert response.status_code == 200
      end
    end

    test "fetch returns successful json responses" do
      with_mock HTTPoison,
        get: fn _url, _headers, _options ->
          {:ok, successful_response(headers: @json_headers, body: @encoded)}
        end do
        assert {:ok, response} = CryptoApis.fetch(@url)
        assert response.body == @decoded
        assert response.request.headers == @json_headers
        assert response.status_code == 200
      end
    end

    test "fetch returns error responses for any error status code outside 200-300" do
      with_mock HTTPoison,
        get: fn _url, _headers, _options ->
          {:error, error_response()}
        end do
        assert CryptoApis.fetch(@url) ==
                 {:error,
                  %HTTPoison.Response{
                    status_code: 404
                  }}

        assert {:error, response} = CryptoApis.fetch(@url)
        assert response.status_code == 404
      end
    end

    test "fetch returns error responses for json error" do
      with_mock HTTPoison,
        get: fn _url, _headers, _options ->
          {:ok, successful_response(headers: @json_headers, body: "bad json")}
        end do
        assert {:error, %Jason.DecodeError{}} = CryptoApis.fetch(@url)
      end
    end
  end

  describe "fetch!/2" do
    test "collects params from top-level" do
      with_mock HTTPoison,
        get!: fn url, _headers, options ->
          successful_response(body: @encoded, url: url, options: options)
        end do
        assert %HTTPoison.Response{} = response = CryptoApis.fetch!(@url, params: [key: :value])
        assert response.request.options == [params: [key: :value]]
      end
    end

    test "fetch! returns successful non-json responses" do
      with_mock HTTPoison,
        get!: fn _url, _headers, _options ->
          successful_response(body: @encoded)
        end do
        assert %HTTPoison.Response{} = response = CryptoApis.fetch!(@url)
        assert response.body == @encoded
        assert response.status_code == 200
      end
    end

    test "fetch! returns successful json responses" do
      with_mock HTTPoison,
        get!: fn _url, _headers, _options ->
          successful_response(headers: @json_headers, body: @encoded)
        end do
        assert %HTTPoison.Response{} = response = CryptoApis.fetch!(@url)
        assert response.body == @decoded
        assert response.status_code == 200
        assert response.request.headers == @json_headers
      end
    end

    test "fetch! does not raise for error codes" do
      with_mock HTTPoison,
        get!: fn _url, _headers, _options ->
          error_response(status_code: 500)
        end do
        assert %HTTPoison.Response{status_code: 500} = CryptoApis.fetch!(@url)
      end
    end

    test "fetch! returns error responses for json error" do
      with_mock HTTPoison,
        get!: fn _url, _headers, _options ->
          successful_response(headers: @json_headers, body: "bad json")
        end do
        assert_raise Jason.DecodeError, fn ->
          CryptoApis.fetch!(@url)
        end
      end
    end
  end
end
