defmodule CryptoApis.Bitkub do
  @moduledoc """
  An API wrapper for the Bitkub exchange.

  Docs: https://github.com/bitkub/bitkub-official-api-docs

  Currently only supports public endpoints.

  """

  @root_url "https://api.bitkub.com/api"

  alias CryptoApis

  defp get_pair({_, _} = pair), do: pair
  defp get_pair(pair), do: CryptoApis.Utils.split_pair(pair)

  defp process_params(params) do
    pair = Keyword.get(params, :pair)
    limit = Keyword.get(params, :limit)
    process_pair(pair) ++ process_limit(limit)
  end

  defp process_limit(nil), do: []

  defp process_limit(limit) do
    [lmt: limit]
  end

  defp process_pair(nil), do: []

  defp process_pair(pair) do
    {crypto, fiat} = get_pair(pair)
    [sym: "#{fiat}_#{crypto}"]
  end

  defp get(type, params, opts) do
    processed = process_params(params)
    opts = Keyword.put(opts, :params, processed)

    type
    |> url()
    |> CryptoApis.get(opts)
  end

  defp url(:orders) do
    market_url() <> "/books"
  end

  defp url(:ticker) do
    market_url() <> "/ticker"
  end

  defp url(:trades) do
    market_url() <> "/trades"
  end

  defp market_url, do: @root_url <> "/market"

  @doc """
  https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md#description-7
  """
  def order_book(pair, limit \\ 100, opts \\ []) do
    get(:orders, [pair: pair, limit: limit], opts)
  end

  @doc """
  https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md#get-apimarketticker
  """
  def ticker(pair \\ nil, opts \\ []) do
    get(:ticker, [pair: pair], opts)
  end

  # @doc """
  # https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md#get-apimarkettrades
  # """
  def trades(pair, limit \\ 100, opts \\ []) do
    get(:trades, [pair: pair, limit: limit], opts)
  end
end
