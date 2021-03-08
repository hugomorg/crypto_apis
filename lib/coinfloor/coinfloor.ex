defmodule CryptoApis.Coinfloor do
  @moduledoc """
  https://github.com/coinfloor/API/blob/master/BIST.md
  """

  @root_url "https://webapi.coinfloor.co.uk/bist"

  alias CryptoApis.Pair

  defp process_pair(pair) do
    pair |> Pair.new() |> Pair.to_tuple()
  end

  defp parse_crypto("BTC"), do: "XBT"
  defp parse_crypto(:BTC), do: "XBT"
  defp parse_crypto(crypto), do: crypto

  defp get(type, pair, opts) do
    {crypto, fiat} = process_pair(pair)

    type
    |> url(parse_crypto(crypto), fiat)
    |> CryptoApis.get(opts)
  end

  defp url(:orders, crypto, fiat) do
    "#{@root_url}/#{crypto}/#{fiat}/order_book/"
  end

  defp url(:ticker, crypto, fiat) do
    "#{@root_url}/#{crypto}/#{fiat}/ticker/"
  end

  defp url(:trades, crypto, fiat) do
    "#{@root_url}/#{crypto}/#{fiat}/transactions/"
  end

  @doc """
  https://github.com/coinfloor/API/blob/master/BIST.md#order-book
  """
  def order_book(pair, opts \\ []) do
    get(:orders, pair, opts)
  end

  @doc """
  https://github.com/coinfloor/API/blob/master/BIST.md#ticker
  """
  def ticker(pair, opts \\ []) do
    get(:ticker, pair, opts)
  end

  @doc """
  https://github.com/coinfloor/API/blob/master/BIST.md#transactions
  """
  def trades(pair, time \\ nil, opts \\ []) do
    opts = if time, do: opts ++ [params: [time: time]], else: opts
    get(:trades, pair, opts)
  end
end
