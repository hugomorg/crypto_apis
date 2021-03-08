defmodule CryptoApis.Coinbase do
  @moduledoc """
  https://docs.pro.coinbase.com
  """

  @root_url "https://api.pro.coinbase.com"

  alias CryptoApis.Pair

  defp process_pair(pair) do
    pair |> Pair.new() |> Pair.join(delimiter: "-")
  end

  defp get(type, pair, level \\ nil, opts) do
    pair = process_pair(pair)

    opts = if level, do: Keyword.put(opts, :params, level: level), else: opts

    type
    |> url(pair)
    |> CryptoApis.get(opts)
  end

  defp url(:orders, pair) do
    "#{products_url()}/#{pair}/book"
  end

  defp url(:ticker, pair) do
    "#{products_url()}/#{pair}/ticker"
  end

  defp url(:trades, pair) do
    "#{products_url()}/#{pair}/trades"
  end

  defp url(:pair, pair) do
    "#{products_url()}/#{pair}"
  end

  defp url(:historic_rates, pair) do
    "#{products_url()}/#{pair}/candles"
  end

  defp url(:stats, pair) do
    "#{products_url()}/#{pair}/stats"
  end

  defp url(:currency, code) do
    "#{currencies_url()}/#{code}"
  end

  defp products_url, do: @root_url <> "/products"
  defp currencies_url, do: @root_url <> "/currencies"
  defp time_url, do: @root_url <> "/time"

  @doc """
  https://docs.pro.coinbase.com/#get-product-order-book
  """
  def order_book(pair, level \\ nil, opts \\ []) do
    get(:orders, pair, level, opts)
  end

  @doc """
  https://docs.pro.coinbase.com/#get-product-ticker
  """
  def ticker(pair, opts \\ []) do
    get(:ticker, pair, opts)
  end

  @doc """
  https://docs.pro.coinbase.com/#get-trades
  """
  def trades(pair, opts \\ []) do
    get(:trades, pair, opts)
  end

  @doc """
  https://docs.pro.coinbase.com/#get-products
  """
  def pairs(opts \\ []) do
    products_url() |> CryptoApis.get(opts)
  end

  @doc """
  https://docs.pro.coinbase.com/#get-single-product
  """
  def pair(pair, opts \\ []) do
    pair = process_pair(pair)
    :pair |> url(pair) |> CryptoApis.get(opts)
  end

  @doc """
  https://docs.pro.coinbase.com/#get-historic-rates
  """
  def historic_rates(pair, params \\ [], opts \\ []) do
    pair = process_pair(pair)
    :historic_rates |> url(pair) |> CryptoApis.get(opts ++ [params: params])
  end

  @doc """
  https://docs.pro.coinbase.com/#get-24hr-stats
  """
  def stats_24h(pair, opts \\ []) do
    pair = process_pair(pair)
    :stats |> url(pair) |> CryptoApis.get(opts)
  end

  @doc """
  https://docs.pro.coinbase.com/#currencies
  """
  def currencies(opts \\ []) do
    currencies_url() |> CryptoApis.get(opts)
  end

  @doc """
  https://docs.pro.coinbase.com/#get-a-currency
  """
  def currency(code, opts \\ []) do
    :currency |> url(code) |> CryptoApis.get(opts)
  end

  @doc """
  https://docs.pro.coinbase.com/#time
  """
  def server_time(opts \\ []) do
    time_url() |> CryptoApis.get(opts)
  end
end
