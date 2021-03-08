defmodule CryptoApis.BitcoinVN do
  @moduledoc """
  https://api.bitcoinvn.io
  """

  @root_url "https://api.bitcoinvn.io/api"

  defp url(:volume, currency, timeframe) do
    "#{@root_url}/volume/#{currency}/#{timeframe}"
  end

  defp url(:prices) do
    @root_url <> "/prices"
  end

  defp url(:history) do
    @root_url <> "/history"
  end

  defp url(:bank_accounts) do
    @root_url <> "/constants/bankaccounts"
  end

  defp url(:constraints) do
    @root_url <> "/constants/constraints"
  end

  @doc """
  https://api.bitcoinvn.io/#get--api-prices
  """
  def prices(opts \\ []) do
    :prices |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://api.bitcoinvn.io/#get--api-history
  """
  def history(opts \\ []) do
    :history |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://api.bitcoinvn.io/#get--api-volume-{currency}-{timeframe}
  """
  def volume(currency, timeframe, opts \\ []) do
    :volume |> url(currency, timeframe) |> CryptoApis.get(opts)
  end

  @doc """
  https://api.bitcoinvn.io/#get--api-constants-bankaccounts
  """
  def bank_accounts(opts \\ []) do
    :bank_accounts |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://api.bitcoinvn.io/#get--api-constants-constraints
  """
  def constraints(opts \\ []) do
    :constraints |> url() |> CryptoApis.get(opts)
  end
end
