defmodule CryptoApis.CoinsPH do
  @moduledoc """
  An API wrapper for the bitFlyer exchange.

  Docs: https://docs.coins.asia/docs/market-rates-v2

  Currently only supports public endpoints.
  """

  @root_url "https://quote.coins.ph/v2"

  alias CryptoApis

  defp get_pair(nil), do: nil
  defp get_pair({_, _} = pair), do: pair
  defp get_pair(pair), do: CryptoApis.Utils.split_pair(pair)

  defp get(type, pair, opts) do
    pair = get_pair(pair)

    type
    |> url(pair)
    |> CryptoApis.get(opts)
  end

  defp url(:orders, nil) do
    @root_url <> "/markets"
  end

  defp url(:orders, {crypto, fiat}) do
    @root_url <> "/markets/#{crypto}-#{fiat}"
  end

  def rates(pair \\ nil, region \\ nil, opts \\ []) do
    opts = if region, do: Keyword.put(opts, :params, region: region), else: opts
    get(:orders, pair, opts)
  end
end
