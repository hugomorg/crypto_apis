defmodule CryptoApis.Upbit do
  @moduledoc """
  https://github.com/Shin-JaeHeon/upbit-api/blob/master/README.md
  """
  @root_url "https://api.upbit.com/v1"

  alias CryptoApis.Pair

  defp url(:order_book) do
    @root_url <> "/orderbook"
  end

  defp url(:ticker) do
    @root_url <> "/ticker"
  end

  defp url(:markets) do
    @root_url <> "/market/all"
  end

  defp url(:trades) do
    @root_url <> "/trades/ticks"
  end

  defp process_pair(pair) do
    pair |> Pair.new() |> Pair.join(delimiter: "-", invert?: true)
  end

  @doc """
  https://github.com/Shin-JaeHeon/upbit-api#orderbookmarket
  """
  def order_book(pair, opts \\ []) do
    params = [markets: process_pair(pair)]

    :order_book
    |> url()
    |> CryptoApis.get(opts ++ [params: params])
  end

  def markets(opts \\ []) do
    :markets
    |> url()
    |> CryptoApis.get(opts)
  end

  @doc """
  https://github.com/Shin-JaeHeon/upbit-api#tickermarket
  """
  def ticker(pair, opts \\ []) do
    params = [markets: process_pair(pair)]

    :ticker
    |> url()
    |> CryptoApis.get(opts ++ [params: params])
  end

  @doc """
  https://github.com/Shin-JaeHeon/upbit-api#ticksmarket-count-to-cursor
  """
  def trades(pair, params \\ [], opts \\ []) do
    params = params ++ [market: process_pair(pair)]

    :trades
    |> url()
    |> CryptoApis.get(opts ++ [params: params])
  end
end
