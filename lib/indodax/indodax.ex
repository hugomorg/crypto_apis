defmodule CryptoApis.Indodax do
  @moduledoc """
  https://github.com/btcid/indodax-official-api-docs/blob/master/Public-RestAPI.md
  """

  @root_url "https://indodax.com/api"

  alias CryptoApis

  defp get_pair({_, _} = pair), do: pair
  defp get_pair(pair), do: CryptoApis.Utils.split_pair(pair)

  defp get(type, pair, opts) do
    {crypto, fiat} = get_pair(pair)
    pair = String.downcase("#{crypto}#{fiat}")

    type
    |> url(pair)
    |> CryptoApis.get(opts)
  end

  defp url(:orders, pair) do
    "#{@root_url}/depth/#{pair}"
  end

  @doc """
  https://github.com/btcid/indodax-official-api-docs/blob/master/Public-RestAPI.md#depth
  """
  def order_book(pair, opts \\ []) do
    get(:orders, pair, opts)
  end
end
