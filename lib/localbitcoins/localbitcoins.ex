defmodule CryptoApis.LocalBitcoins do
  @moduledoc """
  https://localbitcoins.com/api-docs/
  """

  @root_url "https://localbitcoins.com"

  alias CryptoApis.Pair

  @doc """
  https://localbitcoins.com/docs/#ticker-all
  """
  def ticker_all(opts \\ []) do
    url = @root_url <> "/bitcoinaverage/ticker-all-currencies"
    CryptoApis.get(url, opts ++ [options: [follow_redirect: true]])
  end

  @doc """
  https://localbitcoins.com/api-docs/#orderbook
  """
  def order_book(pair, opts \\ []) do
    %{fiat: fiat} = Pair.new(pair)
    url = @root_url <> "/bitcoincharts/#{fiat}/orderbook.json"
    CryptoApis.get(url, opts)
  end
end
