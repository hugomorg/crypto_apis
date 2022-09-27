defmodule CryptoApis.HTTPClient do
  @type data :: map() | list()
  @type headers :: list()
  @type opts :: list()
  @type url :: String.t()

  @type http_poison_response ::
          {:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Response.t() | HTTPoison.Error.t()}

  @callback get(url, headers, opts) :: http_poison_response
  @callback post(url, data, headers, opts) :: http_poison_response

  def impl do
    Application.get_env(:crypto_apis, :http_client, __MODULE__.Impl)
  end
end

defmodule CryptoApis.HTTPClient.Impl do
  @behaviour CryptoApis.HTTPClient

  defdelegate get(url, headers, opts), to: HTTPoison
  defdelegate post(url, data, headers, opts), to: HTTPoison
end
