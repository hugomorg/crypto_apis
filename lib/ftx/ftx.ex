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
      url = "#{FTX.base_url()}/positions"
      headers = build_signature(api_key, api_secret, url, params)

      CryptoApis.get(url, params: params, headers: headers)
    end

    def get_funding_payments(api_key, api_secret, params \\ []) do
      url = "#{FTX.base_url()}/funding_payments"
      headers = build_signature(api_key, api_secret, url, params)

      CryptoApis.get(url, params: params, headers: headers)
    end

    def get_all_historical_balances_and_positions(api_key, api_secret, params \\ []) do
      url = "#{FTX.base_url()}/historical_balances/requests"
      headers = build_signature(api_key, api_secret, url, params)

      CryptoApis.get(url, params: params, headers: headers)
    end

    defp build_signature(api_key, api_secret, method \\ "GET", url, params) do
      timestamp =
        Keyword.get_lazy(params, :timestamp, fn ->
          DateTime.to_unix(DateTime.utc_now(), :millisecond)
        end)

      request_path = URI.parse(url).path

      signature_payload = "#{timestamp}#{method}#{request_path}"

      signature = CryptoApis.hmac(api_secret, signature_payload)

      [
        {"FTX-KEY", api_key},
        {"FTX-TS", timestamp},
        {"FTX-SIGN", signature}
      ]
    end
  end
end
