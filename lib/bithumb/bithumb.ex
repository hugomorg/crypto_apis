defmodule CryptoApis.Bithumb do
  @moduledoc """
  An API wrapper for the Bithumb exchange.

  Docs: https://apidocs.bithumb.com

  Currently only supports public endpoints.

  """
  @root_url "https://api.bithumb.com/public"

  defp get_pair({_, _} = pair), do: pair
  defp get_pair(pair), do: CryptoApis.split_pair(pair)

  defp get(type, pair, opts) do
    {crypto, fiat} = get_pair(pair)

    type
    |> url(crypto, fiat)
    |> CryptoApis.get(opts)
  end

  defp url(:orders, crypto, fiat) do
    @root_url <> "/orderbook" <> "/#{crypto}_#{fiat}"
  end

  defp url(:ticker, crypto, fiat) do
    @root_url <> "/ticker" <> "/#{crypto}_#{fiat}"
  end

  defp url(:trades, crypto, fiat) do
    @root_url <> "/transaction_history" <> "/#{crypto}_#{fiat}"
  end

  @doc """
  https://apidocs.bithumb.com/docs/order_book
  """
  def orders(pair, opts \\ []) do
    get(:orders, pair, opts)
  end

  @doc """
  https://apidocs.bithumb.com/docs/ticker
  """
  def ticker(pair, opts \\ []) do
    get(:ticker, pair, opts)
  end

  @doc """
  https://apidocs.bithumb.com/docs/transaction_history
  """
  def trades(pair, opts \\ []) do
    get(:trades, pair, opts)
  end
end
