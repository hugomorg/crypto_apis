defmodule CryptoApis.Kraken do
  @moduledoc """
  An API wrapper for the Kraken exchange.

  Docs: https://www.kraken.com/features/api

  Currently only supports public endpoints.

  """

  @root_url "https://api.kraken.com"
  @api_version 0

  alias CryptoApis

  defp get(type, opts) do
    type
    |> url()
    |> CryptoApis.get(opts)
  end

  defp url(:server_time) do
    build_public_url("Time")
  end

  defp url(:system_status) do
    build_public_url("SystemStatus")
  end

  defp url(:assets) do
    build_public_url("Assets")
  end

  defp url(:asset_pairs) do
    build_public_url("AssetPairs")
  end

  defp url(:ticker) do
    build_public_url("Ticker")
  end

  defp url(:ohlc) do
    build_public_url("OHLC")
  end

  defp url(:order_book) do
    build_public_url("Depth")
  end

  defp url(:trades) do
    build_public_url("Trades")
  end

  defp url(:spread) do
    build_public_url("Spread")
  end

  defp build_public_url(resource, root \\ @root_url, api_version \\ @api_version) do
    "#{root}/#{api_version}/public/#{resource}"
  end

  @doc """
  https://www.kraken.com/features/api#get-server-time
  """
  def server_time(opts \\ []) do
    get(:server_time, opts)
  end

  @doc """
  https://www.kraken.com/features/api#get-system-status
  """
  def system_status(opts \\ []) do
    get(:system_status, opts)
  end

  @doc """
  https://www.kraken.com/features/api#get-asset-info
  """
  def assets(opts \\ []) do
    get(:assets, opts)
  end

  @doc """
  https://www.kraken.com/features/api#get-tradable-pairs
  """
  def asset_pairs(opts \\ []) do
    get(:asset_pairs, opts)
  end

  @doc """
  https://www.kraken.com/features/api#get-ticker-info
  """
  def ticker(pair_name, opts \\ []) when is_atom(pair_name) or is_binary(pair_name) do
    opts = CryptoApis.Utils.override_params(opts, :pair_name, pair_name)

    get(:ticker, opts)
  end

  @doc """
  https://www.kraken.com/features/api#get-ohlc-data
  """
  def ohlc(pair, opts \\ []) when is_atom(pair) or is_binary(pair) do
    opts = CryptoApis.Utils.override_params(opts, :pair, pair)

    get(:ohlc, opts)
  end

  @doc """
  https://www.kraken.com/features/api#get-order-book
  """
  def order_book(pair, opts \\ []) when is_atom(pair) or is_binary(pair) do
    opts = CryptoApis.Utils.override_params(opts, :pair, pair)

    get(:order_book, opts)
  end

  @doc """
  https://www.kraken.com/features/api#get-recent-trades
  """
  def trades(pair, opts \\ []) when is_atom(pair) or is_binary(pair) do
    opts = CryptoApis.Utils.override_params(opts, :pair, pair)

    get(:trades, opts)
  end

  @doc """
  https://www.kraken.com/features/api#get-recent-spread-data
  """
  def spread(pair, opts \\ []) when is_atom(pair) or is_binary(pair) do
    opts = CryptoApis.Utils.override_params(opts, :pair, pair)

    get(:spread, opts)
  end
end
