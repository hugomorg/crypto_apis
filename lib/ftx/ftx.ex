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

    def get_funding_rates do
      "#{FTX.base_url()}/funding_rates"
      |> CryptoApis.get()
    end
  end
end
