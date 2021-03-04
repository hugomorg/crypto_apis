defmodule CryptoApis.Cryptomkt do
  @moduledoc """
  An API wrapper for the Cryptomkt exchange.

  Docs: https://developers.cryptomkt.com

  Currently only supports public endpoints.
  """

  @root_url "https://api.cryptomkt.com/v1"

  alias CryptoApis

  defp get_pair({crypto, fiat}), do: "#{crypto}#{fiat}"
  defp get_pair(pair), do: pair

  defp get(type, params, opts) do
    params =
      params
      |> Keyword.update(:market, nil, &get_pair/1)
      |> Enum.reject(&(&1 |> elem(1) |> is_nil))

    opts = Keyword.put(opts, :params, params)

    type
    |> url()
    |> CryptoApis.get(opts)
  end

  defp url(:orders) do
    "#{@root_url}/book"
  end

  defp url(:ticker) do
    "#{@root_url}/ticker"
  end

  defp url(:trades) do
    "#{@root_url}/trades"
  end

  @doc """
  https://developers.cryptomkt.com/es/#ordenes
  """
  def order_book(pair, order_type, params \\ [], opts \\ []) do
    params = params |> Keyword.merge(market: pair, type: order_type)
    get(:orders, params, opts)
  end

  @doc """
  https://developers.cryptomkt.com/es/#ticker
  """
  def ticker(pair, opts \\ []) do
    get(:ticker, [market: pair], opts)
  end

  @doc """
  https://developers.cryptomkt.com/es/#trades
  """
  def trades(pair, params \\ [], opts \\ []) do
    params = params |> Keyword.merge(market: pair)
    get(:trades, params, opts)
  end
end
