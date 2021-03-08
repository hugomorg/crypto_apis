defmodule CryptoApis.Bitflyer do
  @moduledoc """
  https://lightning.bitflyer.com/docs?lang=en#http-public-api
  """

  @root_url "https://api.bitflyer.com/v1"

  alias CryptoApis.Pair

  defp process_pair(pair) do
    pair
    |> Pair.new()
    |> Pair.join(delimiter: "_")
  end

  defp get(type, pair, params \\ [], opts) do
    pair = process_pair(pair)

    params = params ++ [product_code: pair]

    opts = Keyword.put(opts, :params, params)

    type
    |> url()
    |> CryptoApis.get(opts)
  end

  defp url(:orders) do
    @root_url <> "/board"
  end

  defp url(:ticker) do
    @root_url <> "/ticker"
  end

  defp url(:trades) do
    @root_url <> "/executions"
  end

  defp url(:markets) do
    @root_url <> "/markets"
  end

  defp url(:order_book_status) do
    @root_url <> "/getboardstate"
  end

  defp url(:exchange_status) do
    @root_url <> "/gethealth"
  end

  defp url(:chats) do
    @root_url <> "/getchats"
  end

  @doc """
  https://lightning.bitflyer.com/docs?lang=en#order-book
  """
  def order_book(pair, opts \\ []) do
    get(:orders, pair, opts)
  end

  @doc """
  https://lightning.bitflyer.com/docs?lang=en#ticker
  """
  def ticker(pair, opts \\ []) do
    get(:ticker, pair, opts)
  end

  @doc """
  https://lightning.bitflyer.com/docs?lang=en#execution-history
  """
  def trades(pair, params \\ [], opts \\ []) do
    get(:trades, pair, params, opts)
  end

  @doc """
  https://lightning.bitflyer.com/docs?lang=en#market-list
  """
  def markets(opts \\ []) do
    :markets
    |> url()
    |> CryptoApis.get(opts)
  end

  @doc """
  https://lightning.bitflyer.com/docs?lang=en#orderbook-status
  """
  def order_book_status(opts \\ []) do
    :order_book_status
    |> url()
    |> CryptoApis.get(opts)
  end

  @doc """
  https://lightning.bitflyer.com/docs?lang=en#exchange-status
  """
  def exchange_status(opts \\ []) do
    :exchange_status
    |> url()
    |> CryptoApis.get(opts)
  end

  @doc """
  https://lightning.bitflyer.com/docs?lang=en#chat
  """
  def chats(params \\ [], opts \\ []) do
    :chats
    |> url()
    |> CryptoApis.get(opts ++ [params: params])
  end
end
