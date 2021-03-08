defmodule CryptoApis.Cryptomkt do
  @moduledoc """
  https://developers.cryptomkt.com
  """

  @root_url "https://api.cryptomkt.com/v1"

  alias CryptoApis.Pair

  defp process_pair(pair) do
    pair |> Pair.new() |> to_string()
  end

  defp get(type, params, opts) do
    opts = Keyword.put(opts, :params, params)

    type
    |> url()
    |> CryptoApis.get(opts)
  end

  defp url(:orders) do
    "#{@root_url}/book"
  end

  defp url(:ticker) do
    "#{@root_url}/ticker"
  end

  defp url(:trades) do
    "#{@root_url}/trades"
  end

  defp url(:markets) do
    "#{@root_url}/market"
  end

  defp url(:prices) do
    "#{@root_url}/prices"
  end

  @doc """
  https://developers.cryptomkt.com/es/#ordenes
  """
  def order_book(pair, order_type, params \\ [], opts \\ []) do
    params = params ++ [market: process_pair(pair), type: order_type]
    get(:orders, params, opts)
  end

  @doc """
  https://developers.cryptomkt.com/es/#ticker
  """
  def ticker(pair, opts \\ []) do
    params = [market: process_pair(pair)]
    get(:ticker, params, opts)
  end

  @doc """
  https://developers.cryptomkt.com/es/#trades
  """
  def trades(pair, params \\ [], opts \\ []) do
    params = params ++ [market: process_pair(pair)]
    get(:trades, params, opts)
  end

  @doc """
  https://developers.cryptomkt.com/es/#mercado
  """
  def markets(opts \\ []) do
    :markets |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://developers.cryptomkt.com/es/#precios
  """
  def prices(pair, timeframe, params \\ [], opts \\ []) do
    params = params ++ [market: process_pair(pair), timeframe: timeframe]
    get(:prices, params, opts)
  end
end
