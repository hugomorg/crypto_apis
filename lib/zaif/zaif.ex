defmodule CryptoApis.Zaif do
  @moduledoc """
  https://zaif-api-document.readthedocs.io/ja/latest/index.html
  """

  @root_url "https://api.zaif.jp/api/1"

  alias CryptoApis.Pair

  defp url(:currency_info, pair) do
    "#{@root_url}/currencies/#{pair}"
  end

  defp url(:pair_info, pair) do
    "#{@root_url}/currency_pairs/#{pair}"
  end

  defp url(:last_price, pair) do
    "#{@root_url}/last_price/#{pair}"
  end

  defp url(:ticker, pair) do
    "#{@root_url}/ticker/#{pair}"
  end

  defp url(:trades, pair) do
    "#{@root_url}/trades/#{pair}"
  end

  defp url(:order_book, pair) do
    "#{@root_url}/depth/#{pair}"
  end

  defp process_pair(pair), do: pair |> Pair.new() |> Pair.join(delimiter: "_", downcase?: true)

  @doc """
  https://zaif-api-document.readthedocs.io/ja/latest/PublicAPI.html#id7
  """
  def currency_info(crypto, opts \\ []) do
    :currency_info |> url(String.downcase("#{crypto}")) |> CryptoApis.get(opts)
  end

  @doc """
  https://zaif-api-document.readthedocs.io/ja/latest/PublicAPI.html#id7
  """
  def pair_info(pair, opts \\ []) do
    pair = process_pair(pair)
    url(:pair_info, pair) |> CryptoApis.get(opts)
  end

  @doc """
  https://zaif-api-document.readthedocs.io/ja/latest/PublicAPI.html#id17
  """
  def last_price(pair, opts \\ []) do
    pair = process_pair(pair)
    url(:last_price, pair) |> CryptoApis.get(opts)
  end

  @doc """
  https://zaif-api-document.readthedocs.io/ja/latest/PublicAPI.html#id22
  """
  def ticker(pair, opts \\ []) do
    pair = process_pair(pair)
    url(:ticker, pair) |> CryptoApis.get(opts)
  end

  @doc """
  https://zaif-api-document.readthedocs.io/ja/latest/PublicAPI.html#id28
  """
  def trades(pair, opts \\ []) do
    pair = process_pair(pair)
    url(:trades, pair) |> CryptoApis.get(opts)
  end

  @doc """
  https://zaif-api-document.readthedocs.io/ja/latest/PublicAPI.html#id34
  """
  def order_book(pair, opts \\ []) do
    pair = process_pair(pair)
    url(:order_book, pair) |> CryptoApis.get(opts)
  end
end
