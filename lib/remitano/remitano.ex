defmodule CryptoApis.Remitano do
  @moduledoc """
  https://developers.remitano.com/api-explorer
  """

  @root_url "https://api.remitano.com/api/v1"

  alias CryptoApis.Utils

  defp get(resource, pair, params, opts) do
    pair = Utils.pair_to_string(pair)

    resource
    |> url(pair)
    |> CryptoApis.get(opts ++ [params: params])
  end

  defp url(:order_book, pair) do
    "#{@root_url}/markets/#{pair}/order_book"
  end

  defp url(:trades, pair) do
    "#{@root_url}/markets/#{pair}/trades"
  end

  defp url(:markets) do
    @root_url <> "/markets/info"
  end

  defp url(:volumes) do
    @root_url <> "/volumes/market_summaries"
  end

  defp url(:currencies) do
    @root_url <> "/currencies/info"
  end

  def order_book(pair, params \\ [], opts \\ []) do
    get(:order_book, pair, params, opts)
  end

  def trades(pair, params \\ [], opts \\ []) do
    get(:trades, pair, params, opts)
  end

  def volume(opts \\ []) do
    :volumes |> url() |> CryptoApis.get(opts)
  end

  def currencies(opts \\ []) do
    :currencies |> url() |> CryptoApis.get(opts)
  end

  def markets(opts \\ []) do
    :markets
    |> url()
    |> CryptoApis.get(opts)
  end
end
