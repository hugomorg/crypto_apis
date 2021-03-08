defmodule CryptoApis.CoinsPH do
  @moduledoc """
  https://docs.coins.asia/docs/market-rates-v2
  """

  @root_url "https://quote.coins.ph/v2"

  alias CryptoApis.Pair

  defp process_pair(pair) do
    pair |> Pair.new() |> Pair.join(delimiter: "-")
  end

  defp get(type, pair, opts) do
    pair = pair && process_pair(pair)

    type
    |> url(pair)
    |> CryptoApis.get(opts)
  end

  defp url(:orders, nil) do
    @root_url <> "/markets"
  end

  defp url(:orders, pair) do
    @root_url <> "/markets/#{pair}"
  end

  def rates(pair \\ nil, region \\ nil, opts \\ []) do
    opts = if region, do: Keyword.put(opts, :params, region: region), else: opts
    get(:orders, pair, opts)
  end
end
