defmodule CryptoApis.FTX do
  @base_url "https://ftx.com/api"

  def base_url, do: @base_url

  defmodule Futures do
    alias CryptoApis.FTX
    @base_path "/futures"

    def get_futures do
      "#{FTX.base_url()}#{@base_path}"
      |> CryptoApis.get()
    end

    def get_future(future) when is_binary(future) do
      "#{FTX.base_url()}#{@base_path}/#{future}"
      |> CryptoApis.get()
    end

    def get_funding_rate(future) when is_binary(future) do
      "#{FTX.base_url()}/funding_rates"
      |> CryptoApis.get(params: [future: future])
    end

    def get_funding_rates(params \\ []) do
      "#{FTX.base_url()}/funding_rates"
      |> CryptoApis.get(params: params)
    end

    def get_current_positions(api_key, api_secret, params \\ []) do
      timestamp = DateTime.to_unix(DateTime.utc_now(), :millisecond)
      method = "GET"
      request_path = "/api/positions"

      signature_payload = "#{timestamp}#{method}#{request_path}"

      signature = CryptoApis.hmac(api_secret, signature_payload)

      headers = [
        {"FTX-KEY", api_key},
        {"FTX-TS", timestamp},
        {"FTX-SIGN", signature}
      ]

      "#{FTX.base_url()}/positions"
      |> CryptoApis.get(params: params, headers: headers)
    end
  end
end
