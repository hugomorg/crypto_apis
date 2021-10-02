defmodule CryptoApis.Cryptomkt do
  @moduledoc """
  https://developers.cryptomkt.com
  """

  @root_url "https://api.exchange.cryptomkt.com/api/3/public"

  alias CryptoApis.Pair

  defp process_pair(pair) do
    pair |> Pair.new() |> to_string()
  end

  @doc """
  https://api.exchange.cryptomkt.com/#order-books
  """
  def order_book(pair, opts \\ []) do
    CryptoApis.get("#{@root_url}/orderbook/#{process_pair(pair)}", opts)
  end

  @doc """
  https://api.exchange.cryptomkt.com/#tickers
  """
  def ticker(pair, params \\ [], opts \\ []) do
    params = params |> Keyword.put(:symbols, process_pair(pair))
    CryptoApis.get("#{@root_url}/ticker", opts ++ [params: params])
  end
end
