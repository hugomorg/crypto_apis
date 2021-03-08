defmodule CryptoApis.Bitstamp do
  @moduledoc """
  https://www.bitstamp.net/api/
  """

  @root_url "https://www.bitstamp.net/api/v2"

  alias CryptoApis.Pair

  defp process_pair(pair) do
    pair |> Pair.new() |> Pair.join(downcase?: true)
  end

  defp get(type, pair, opts) do
    pair = process_pair(pair)

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

  defp url(:hourly_ticker, pair) do
    "#{@root_url}/ticker_hour/#{pair}/"
  end

  defp url(:trades, pair) do
    "#{@root_url}/transactions/#{pair}/"
  end

  defp url(:ohlc, pair) do
    "#{@root_url}/ohlc/#{pair}/"
  end

  defp url(:pairs) do
    "#{@root_url}/trading-pairs-info/"
  end

  def order_book(pair, opts \\ []) do
    get(:orders, pair, opts)
  end

  def ticker(pair, opts \\ []) do
    get(:ticker, pair, opts)
  end

  def hourly_ticker(pair, opts \\ []) do
    get(:hourly_ticker, pair, opts)
  end

  def trades(pair, opts \\ []) do
    get(:trades, pair, opts)
  end

  def ohlc(pair, params \\ [], opts \\ []) do
    params = params |> Keyword.put_new(:step, 60) |> Keyword.put_new(:limit, 100)
    pair = process_pair(pair)
    :ohlc |> url(pair) |> CryptoApis.get(opts ++ [params: params])
  end

  def pairs(opts \\ []) do
    :pairs |> url() |> CryptoApis.get(opts)
  end
end
