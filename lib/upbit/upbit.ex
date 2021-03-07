defmodule CryptoApis.Upbit do
  @moduledoc """
  https://github.com/Shin-JaeHeon/upbit-api/blob/master/README.md
  """
  @root_url "https://api.upbit.com/v1"

  def url(:order_book) do
    @root_url <> "/orderbook"
  end

  def url(:ticker) do
    @root_url <> "/ticker"
  end

  def url(:markets) do
    @root_url <> "/market/all"
  end

  def url(:trades) do
    @root_url <> "/trades/ticks"
  end

  @doc """
  https://github.com/Shin-JaeHeon/upbit-api#orderbookmarket
  """
  def order_book(pair, opts \\ []) do
    %{crypto: crypto, fiat: fiat} = pair |> CryptoApis.Pair.new()
    params = [markets: "#{fiat}-#{crypto}"]

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
    %{crypto: crypto, fiat: fiat} = pair |> CryptoApis.Pair.new()
    params = [markets: "#{fiat}-#{crypto}"]

    :ticker
    |> url()
    |> CryptoApis.get(opts ++ [params: params])
  end

  @doc """
  https://github.com/Shin-JaeHeon/upbit-api#ticksmarket-count-to-cursor
  """
  def trades(pair, params \\ [], opts \\ []) do
    %{crypto: crypto, fiat: fiat} = pair |> CryptoApis.Pair.new()
    params = params ++ [market: "#{fiat}-#{crypto}"]

    :trades
    |> url()
    |> CryptoApis.get(opts ++ [params: params])
  end
end
