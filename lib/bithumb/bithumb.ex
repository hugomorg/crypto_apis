defmodule CryptoApis.Bithumb do
  @moduledoc """
  https://apidocs.bithumb.com
  """
  @root_url "https://api.bithumb.com/public"

  alias CryptoApis.Pair

  defp process_pair(pair) do
    pair |> Pair.new() |> Pair.join(delimiter: "_")
  end

  defp get(type, pair, opts) do
    pair = process_pair(pair)

    type
    |> url(pair)
    |> CryptoApis.get(opts)
  end

  defp url(:orders, pair) do
    @root_url <> "/orderbook" <> "/#{pair}"
  end

  defp url(:ticker, pair) do
    @root_url <> "/ticker" <> "/#{pair}"
  end

  defp url(:trades, pair) do
    @root_url <> "/transaction_history" <> "/#{pair}"
  end

  defp url(:asset_status, crypto) do
    @root_url <> "/assetsstatus" <> "/#{crypto}"
  end

  defp url(:btci) do
    @root_url <> "/btci"
  end

  @doc """
  https://apidocs.bithumb.com/docs/order_book
  """
  def order_book(pair, opts \\ []) do
    get(:orders, pair, opts)
  end

  @doc """
  https://apidocs.bithumb.com/docs/ticker
  """
  def ticker(pair, opts \\ []) do
    get(:ticker, pair, opts)
  end

  @doc """
  https://apidocs.bithumb.com/docs/transaction_history
  """
  def trades(pair, opts \\ []) do
    get(:trades, pair, opts)
  end

  @doc """
  https://apidocs.bithumb.com/docs/assets_status
  """
  def asset_status(crypto, opts \\ []) do
    :asset_status |> url(crypto) |> CryptoApis.get(opts)
  end

  @doc """
  https://apidocs.bithumb.com/docs/btci
  """
  def btci(opts \\ []) do
    :btci |> url() |> CryptoApis.get(opts)
  end
end
