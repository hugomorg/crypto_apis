defmodule CryptoApis.Bitkub do
  @moduledoc """
  https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md
  """

  @root_url "https://api.bitkub.com/api"

  alias CryptoApis.Pair

  defp process_pair(pair) do
    pair |> Pair.new() |> Pair.join(delimiter: "_", invert?: true)
  end

  defp url(:order_book) do
    market_url() <> "/books"
  end

  defp url(:bids) do
    market_url() <> "/bids"
  end

  defp url(:asks) do
    market_url() <> "/asks"
  end

  defp url(:ticker) do
    market_url() <> "/ticker"
  end

  defp url(:trades) do
    market_url() <> "/trades"
  end

  defp url(:status) do
    @root_url <> "/status"
  end

  defp url(:server_time) do
    @root_url <> "/servertime"
  end

  defp url(:symbols) do
    market_url() <> "/symbols"
  end

  defp url(:depth) do
    market_url() <> "/depth"
  end

  defp market_url, do: @root_url <> "/market"

  defp put_pair(params \\ [], pair) do
    params |> Keyword.put(:sym, process_pair(pair))
  end

  defp put_limit(params, limit) do
    params |> Keyword.put(:lmt, limit)
  end

  @doc """
  https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md#get-apistatus
  """
  def status(opts \\ []) do
    :status |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md#get-apimarketsymbols
  """
  def symbols(opts \\ []) do
    :symbols |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md#get-apiservertime
  """
  def server_time(opts \\ []) do
    :server_time |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md#description-7
  """
  def order_book(pair, limit \\ 100, opts \\ []) do
    params = put_pair(pair) |> put_limit(limit)
    :order_book |> url() |> CryptoApis.get(opts ++ [params: params])
  end

  @doc """
  https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md#get-apimarketbids
  """
  def bids(pair, limit \\ 100, opts \\ []) do
    params = put_pair(pair) |> put_limit(limit)
    :bids |> url() |> CryptoApis.get(opts ++ [params: params])
  end

  @doc """
  https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md#get-apimarketasks
  """
  def asks(pair, limit \\ 100, opts \\ []) do
    params = put_pair(pair) |> put_limit(limit)
    :asks |> url() |> CryptoApis.get(opts ++ [params: params])
  end

  @doc """
  https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md#get-apimarketticker
  """

  def ticker(pair \\ nil, opts \\ []) do
    params = if pair, do: put_pair(pair), else: nil
    opts = if params, do: opts ++ [params: params], else: opts
    :ticker |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md#get-apimarkettrades
  """
  def trades(pair, limit \\ 100, opts \\ []) do
    params = put_pair(pair) |> put_limit(limit)
    :trades |> url() |> CryptoApis.get(opts ++ [params: params])
  end

  @doc """
  https://github.com/bitkub/bitkub-official-api-docs/blob/master/restful-api.md#get-apimarketdepth
  """
  def depth(pair, limit \\ 100, opts \\ []) do
    params = put_pair(pair) |> put_limit(limit)
    :depth |> url() |> CryptoApis.get(opts ++ [params: params])
  end
end
