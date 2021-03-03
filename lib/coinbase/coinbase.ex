defmodule CryptoApis.Coinbase do
  @moduledoc """
  An API wrapper for the bitFlyer exchange.

  Docs: https://docs.pro.coinbase.com

  Currently only supports public endpoints.
  """

  @root_url "https://api.pro.coinbase.com/products"

  alias CryptoApis

  defp get_pair({_, _} = pair), do: pair
  defp get_pair(pair), do: CryptoApis.Utils.split_pair(pair)

  defp get(type, pair, level \\ nil, opts) do
    {crypto, fiat} = get_pair(pair)
    pair = "#{crypto}-#{fiat}"
    opts = if level, do: Keyword.put(opts, :params, level: level), else: opts

    type
    |> url(pair)
    |> CryptoApis.get(opts)
  end

  defp url(:orders, pair) do
    "#{@root_url}/#{pair}/book"
  end

  defp url(:ticker, pair) do
    "#{@root_url}/#{pair}/ticker"
  end

  defp url(:trades, pair) do
    "#{@root_url}/#{pair}/trades"
  end

  def order_book(pair, level \\ nil, opts \\ []) do
    get(:orders, pair, level, opts)
  end

  def ticker(pair, opts \\ []) do
    get(:ticker, pair, opts)
  end

  def trades(pair, opts \\ []) do
    get(:trades, pair, opts)
  end
end
