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
end
