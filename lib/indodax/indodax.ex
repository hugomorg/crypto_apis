defmodule CryptoApis.Indodax do
  @moduledoc """
  https://github.com/btcid/indodax-official-api-docs/blob/master/Public-RestAPI.md
  """

  @root_url "https://indodax.com/api"

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
    "#{@root_url}/depth/#{pair}"
  end

  defp url(:trades, pair) do
    "#{@root_url}/trades/#{pair}"
  end

  defp url(:ticker, pair) do
    "#{@root_url}/ticker/#{pair}"
  end

  defp url(:ticker_all) do
    "#{@root_url}/ticker_all"
  end

  defp url(:server_time) do
    "#{@root_url}/server_time/"
  end

  defp url(:pairs) do
    "#{@root_url}/pairs/"
  end

  defp url(:price_increments) do
    "#{@root_url}/price_increments/"
  end

  defp url(:summaries) do
    "#{@root_url}/summaries/"
  end

  @doc """
  https://github.com/btcid/indodax-official-api-docs/blob/master/Public-RestAPI.md#depth
  """
  def order_book(pair, opts \\ []) do
    get(:orders, pair, opts)
  end

  @doc """
  https://github.com/btcid/indodax-official-api-docs/blob/master/Public-RestAPI.md#trades
  """
  def trades(pair, opts \\ []) do
    get(:trades, pair, opts)
  end

  @doc """
  https://github.com/btcid/indodax-official-api-docs/blob/master/Public-RestAPI.md#ticker
  """
  def ticker(pair, opts \\ []) do
    get(:ticker, pair, opts)
  end

  @doc """
  https://github.com/btcid/indodax-official-api-docs/blob/master/Public-RestAPI.md#server-time
  """
  def server_time(opts \\ []) do
    :server_time |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://github.com/btcid/indodax-official-api-docs/blob/master/Public-RestAPI.md#price-increments
  """
  def price_increments(opts \\ []) do
    :price_increments |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://github.com/btcid/indodax-official-api-docs/blob/master/Public-RestAPI.md#pairs
  """
  def pairs(opts \\ []) do
    :pairs |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://github.com/btcid/indodax-official-api-docs/blob/master/Public-RestAPI.md#summaries
  """
  def summaries(opts \\ []) do
    :summaries |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://github.com/btcid/indodax-official-api-docs/blob/master/Public-RestAPI.md#ticker-all
  """
  def ticker_all(opts \\ []) do
    :ticker_all |> url() |> CryptoApis.get(opts)
  end
end
