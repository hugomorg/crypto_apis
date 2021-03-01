defmodule CryptoApis.BitcoinVN do
  @moduledoc """
  An API wrapper for the BitcoinVN exchange.

  Docs: https://api.bitcoinvn.io

  Currently only supports public endpoints.

  """

  @root_url "https://api.bitcoinvn.io/api"

  alias CryptoApis

  defp get(type, opts) do
    type
    |> url()
    |> CryptoApis.get(opts)
  end

  defp url(:volume, currency, timeframe) do
    build_public_url(:volume, currency, timeframe)
  end

  defp url(resource) do
    build_public_url(resource)
  end

  defp build_public_url(url = :volume, currency, timeframe) do
    build_public_url(url) <> "/#{currency}/#{timeframe}"
  end

  defp build_public_url(resource) do
    "#{@root_url}/#{resource}"
  end

  @doc """
  https://api.bitcoinvn.io/#get--api-prices
  """
  def prices(opts \\ []) do
    get(:prices, opts)
  end

  @doc """
  https://api.bitcoinvn.io/#get--api-history
  """
  def history(opts \\ []) do
    get(:history, opts)
  end

  @doc """
  https://api.bitcoinvn.io/#get--api-volume-{currency}-{timeframe}
  """
  def volume(currency, timeframe, opts \\ []) do
    url = url(:volume, currency, timeframe)
    CryptoApis.get(url, opts)
  end
end
