defmodule CryptoApis.IndependentReserve do
  @moduledoc """
  An API wrapper for the Independent Reserve exchange.

  https://www.independentreserve.com/products/api#public-methods

  Currently only supports public endpoints.
  """

  @root_url "https://api.independentreserve.com/Public"

  alias CryptoApis

  defp get_pair({_, _} = pair), do: pair
  defp get_pair(pair), do: CryptoApis.Utils.split_pair(pair)
  defp parse_crypto("BTC"), do: "xbt"
  defp parse_crypto(crypto), do: String.downcase(crypto)

  defp get(type, pair, opts) do
    {crypto, fiat} = get_pair(pair)

    params = [
      primaryCurrencyCode: parse_crypto(crypto),
      secondaryCurrencyCode: String.downcase(fiat)
    ]

    type
    |> url()
    |> CryptoApis.get(opts ++ [params: params])
  end

  defp url(:orders) do
    @root_url <> "/GetOrderBook"
  end

  @doc """
  https://www.independentreserve.com/products/api#GetOrderBook
  """
  def order_book(pair, opts \\ []) do
    get(:orders, pair, opts)
  end
end
