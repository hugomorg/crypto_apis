defmodule CryptoApis.Kraken do
  @moduledoc """
  An API wrapper for the Kraken exchange.

  Docs: https://www.kraken.com/features/api
  """

  @root_url "https://api.kraken.com"
  @api_version 0

  alias CryptoApis

  defp fetch(type, opts) do
    type
    |> url()
    |> CryptoApis.fetch(opts)
  end

  defp fetch!(type, opts) do
    type
    |> url()
    |> CryptoApis.fetch!(opts)
  end

  def url(:server_time) do
    build_public_url("Time")
  end

  def url(:system_status) do
    build_public_url("SystemStatus")
  end

  def url(:assets) do
    build_public_url("Assets")
  end

  def url(:asset_pairs) do
    build_public_url("AssetPairs")
  end

  def url(:ticker) do
    build_public_url("Ticker")
  end

  def url(:ohlc) do
    build_public_url("OHLC")
  end

  def url(:order_book) do
    build_public_url("Depth")
  end

  def url(:trades) do
    build_public_url("Trades")
  end

  def url(:spread) do
    build_public_url("Spread")
  end

  defp build_public_url(resource, root \\ @root_url, api_version \\ @api_version) do
    "#{root}/#{api_version}/public/#{resource}"
  end

  def server_time(opts \\ []) do
    fetch(:server_time, opts)
  end

  def server_time!(opts \\ []) do
    fetch!(:server_time, opts)
  end

  def system_status(opts \\ []) do
    fetch(:system_status, opts)
  end

  def system_status!(opts \\ []) do
    fetch!(:system_status, opts)
  end

  def assets(opts \\ []) do
    fetch(:assets, opts)
  end

  def assets!(opts \\ []) do
    fetch!(:assets, opts)
  end

  def asset_pairs(opts \\ []) do
    fetch(:asset_pairs, opts)
  end

  def asset_pairs!(opts \\ []) do
    fetch!(:asset_pairs, opts)
  end

  def ticker(pair_name, opts \\ []) when is_atom(pair_name) or is_binary(pair_name) do
    opts = CryptoApis.override_params(opts, :pair_name, pair_name)

    fetch(:ticker, opts)
  end

  def ticker!(pair_name, opts \\ []) when is_atom(pair_name) or is_binary(pair_name) do
    opts = CryptoApis.override_params(opts, :pair_name, pair_name)

    fetch!(:ticker, opts)
  end

  def ohlc(pair, opts \\ []) when is_atom(pair) or is_binary(pair) do
    opts = CryptoApis.override_params(opts, :pair, pair)

    fetch(:ohlc, opts)
  end

  def ohlc!(pair, opts \\ []) when is_atom(pair) or is_binary(pair) do
    opts = CryptoApis.override_params(opts, :pair, pair)

    fetch!(:ohlc, opts)
  end

  def order_book(pair, opts \\ []) when is_atom(pair) or is_binary(pair) do
    opts = CryptoApis.override_params(opts, :pair, pair)

    fetch(:order_book, opts)
  end

  def order_book!(pair, opts \\ []) when is_atom(pair) or is_binary(pair) do
    opts = CryptoApis.override_params(opts, :pair, pair)

    fetch!(:order_book, opts)
  end

  def trades(pair, opts \\ []) when is_atom(pair) or is_binary(pair) do
    opts = CryptoApis.override_params(opts, :pair, pair)

    fetch(:trades, opts)
  end

  def trades!(pair, opts \\ []) when is_atom(pair) or is_binary(pair) do
    opts = CryptoApis.override_params(opts, :pair, pair)

    fetch!(:trades, opts)
  end

  def spread(pair, opts \\ []) when is_atom(pair) or is_binary(pair) do
    opts = CryptoApis.override_params(opts, :pair, pair)

    fetch(:spread, opts)
  end

  def spread!(pair, opts \\ []) when is_atom(pair) or is_binary(pair) do
    opts = CryptoApis.override_params(opts, :pair, pair)

    fetch!(:spread, opts)
  end
end
