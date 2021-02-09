defmodule CryptoApisTest do
  use ExUnit.Case
  doctest CryptoApis
  import Mock

  @data %{key: :value}
  @encoded Jason.encode!(@data)
  @decoded Jason.decode!(@encoded)
  @url "http://localhost:4000"
  @json_headers [{"Content-Type", "application/json"}]

  def successful_response(opts \\ []) do
    status_code = Keyword.get(opts, :status_code, 200)
    body = Keyword.get(opts, :body)
    headers = Keyword.get(opts, :headers, [])
    url = Keyword.get(opts, :url)
    %HTTPoison.Response{status_code: status_code, body: body, headers: headers, request_url: url}
  end

  def error_response(opts \\ []) do
    status_code = Keyword.get(opts, :status_code, 404)
    %HTTPoison.Response{status_code: status_code}
  end

  describe "fetch/2" do
    test "fetch returns successful non-json responses" do
      with_mock HTTPoison,
        get: fn _url, _headers, _options ->
          {:ok, successful_response(body: @encoded)}
        end do
        assert CryptoApis.fetch(@url) ==
                 {:ok, %HTTPoison.Response{body: @encoded, status_code: 200}}
      end
    end

    test "fetch returns successful json responses" do
      with_mock HTTPoison,
        get: fn _url, _headers, _options ->
          {:ok, successful_response(headers: @json_headers, body: @encoded)}
        end do
        assert CryptoApis.fetch(@url) ==
                 {:ok,
                  %HTTPoison.Response{
                    body: @decoded,
                    status_code: 200,
                    headers: @json_headers
                  }}
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
    test "fetch! returns successful non-json responses" do
      with_mock HTTPoison,
        get!: fn _url, _headers, _options ->
          successful_response(body: @encoded)
        end do
        assert CryptoApis.fetch!(@url) ==
                 %HTTPoison.Response{body: @encoded, status_code: 200}
      end
    end

    test "fetch! returns successful json responses" do
      with_mock HTTPoison,
        get!: fn _url, _headers, _options ->
          successful_response(headers: @json_headers, body: @encoded)
        end do
        assert CryptoApis.fetch!(@url) ==
                 %HTTPoison.Response{
                   body: @decoded,
                   status_code: 200,
                   headers: @json_headers
                 }
      end
    end

    test "fetch! does not raise for error codes" do
      with_mock HTTPoison,
        get!: fn _url, _headers, _options ->
          error_response(status_code: 500)
        end do
        assert %HTTPoison.Response{
          status_code: 500
        }
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
