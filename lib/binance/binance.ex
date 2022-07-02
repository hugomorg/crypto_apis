defmodule CryptoApis.Binance do
  @moduledoc """
  Adapted from: https://github.com/sanchezmarcos/binancio
  """

  alias CryptoApis.Pair

  @root_url "https://p2p.binance.com/bapi/c2c/v2/friendly/c2c/adv/search"

  def p2p_prices(pair, data \\ [], opts \\ []) do
    %{crypto: crypto, fiat: fiat} = Pair.new(pair)
    headers = [{"content-type", "application/json"}]
    opts = Keyword.update(opts, :headers, headers, &(&1 ++ headers))

    data =
      data
      |> Keyword.put_new(:page, 1)
      |> Keyword.put_new(:payTypes, [])
      |> Keyword.put_new(:publisherType, nil)
      |> Keyword.put_new(:rows, 20)
      |> Keyword.put_new(:tradeType, "BUY")
      |> Keyword.merge(asset: crypto, fiat: fiat)
      |> Enum.into(%{})
      |> Jason.encode!()

    CryptoApis.post(@root_url, data, opts)
  end
end
