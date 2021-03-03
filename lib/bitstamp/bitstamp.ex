defmodule CryptoApis.Bitstamp do
  @moduledoc """
  An API wrapper for the bitFlyer exchange.

  Docs: https://www.bitstamp.net/api/

  Currently only supports public endpoints.
  """

  @root_url "https://www.bitstamp.net/api/v2"

  alias CryptoApis

  defp get_pair({crypto, fiat}), do: "#{crypto}#{fiat}"
  defp get_pair(pair), do: "#{pair}"

  defp get(type, pair, opts) do
    pair = pair |> get_pair() |> String.downcase()

    type
    |> url(pair)
    |> CryptoApis.get(opts)
  end

  defp url(:orders, pair) do
    "#{@root_url}/order_book/#{pair}/"
  end

  defp url(:ticker, pair) do
    "#{@root_url}/ticker/#{pair}/"
  end

  defp url(:trades, pair) do
    "#{@root_url}/transactions/#{pair}/"
  end

  def order_book(pair, opts \\ []) do
    get(:orders, pair, opts)
  end

  def ticker(pair, opts \\ []) do
    get(:ticker, pair, opts)
  end

  def trades(pair, opts \\ []) do
    get(:trades, pair, opts)
  end
end
