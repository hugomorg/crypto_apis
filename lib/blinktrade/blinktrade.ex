defmodule CryptoApis.Blinktrade do
  @moduledoc """
  https://blinktrade.com/docs/#public-rest-api
  """

  @root_url "https://api.blinktrade.com/api/v1/"

  alias CryptoApis.Pair

  @doc """
  https://blinktrade.com/docs/#ticker
  """
  def ticker(pair, opts \\ []) do
    %{crypto: crypto, fiat: fiat} = Pair.new(pair)
    url = @root_url <> "#{fiat}/ticker?crypto_currency=#{crypto}"
    CryptoApis.get(url, opts)
  end

  @doc """
  https://blinktrade.com/docs/#orderbook
  """
  def order_book(pair, opts \\ []) do
    %{crypto: crypto, fiat: fiat} = Pair.new(pair)
    url = @root_url <> "#{fiat}/orderbook?crypto_currency=#{crypto}"
    CryptoApis.get(url, opts)
  end

  @doc """
  https://blinktrade.com/docs/#trades
  """
  def trades(pair, params \\ [], opts \\ []) do
    %{crypto: crypto, fiat: fiat} = Pair.new(pair)
    url = @root_url <> "#{fiat}/trades?crypto_currency=#{crypto}"
    CryptoApis.get(url, opts ++ [params: params])
  end
end
