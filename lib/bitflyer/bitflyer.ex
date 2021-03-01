defmodule CryptoApis.Bitflyer do
  @moduledoc """
  An API wrapper for the bitFlyer exchange.

  Docs: https://lightning.bitflyer.com/docs?lang=en#http-public-api

  Currently only supports public endpoints.

  """

  @root_url "https://api.bitflyer.com/v1"

  alias CryptoApis

  defp get_pair({_, _} = pair), do: pair
  defp get_pair(pair), do: CryptoApis.Utils.split_pair(pair)

  defp get(type, pair, opts) do
    {crypto, fiat} = get_pair(pair)
    opts = CryptoApis.Utils.override_params(opts, :product_code, "#{crypto}_#{fiat}")

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

  @doc """
  https://lightning.bitflyer.com/docs?lang=en#order-book
  """
  def orders(pair, opts \\ []) do
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
  def trades(pair, opts \\ []) do
    get(:trades, pair, opts)
  end
end
