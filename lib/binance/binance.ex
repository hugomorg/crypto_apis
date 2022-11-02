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

  def build_signature(api_secret, params) do
    params =
      Keyword.put_new_lazy(params, :timestamp, fn ->
        DateTime.utc_now() |> DateTime.to_unix(:millisecond)
      end)

    query_params = URI.encode_query(params)

    signature = CryptoApis.hmac(api_secret, query_params)
    params ++ [signature: signature]
  end
end

defmodule CryptoApis.Binance.Futures do
  @base_url "https://fapi.binance.com/fapi/"
  def base_url, do: @base_url

  defdelegate get_futures, to: __MODULE__.V1
  defdelegate get_future(symbol), to: __MODULE__.V1
  defdelegate get_exchange_info, to: __MODULE__.V1
  defdelegate get_funding_rate(opts \\ []), to: __MODULE__.V1
  defdelegate mark_price, to: __MODULE__.V1
  defdelegate mark_price(symbol), to: __MODULE__.V1
  defdelegate get_income_history(api_key, api_secret, params \\ []), to: __MODULE__.V1

  defdelegate get_download_id_for_futures_transaction_history(api_key, api_secret, params \\ []),
    to: __MODULE__.V1

  defdelegate get_futures_transaction_history_download_link_by_id(
                api_key,
                api_secret,
                params \\ []
              ),
              to: __MODULE__.V1
end

defmodule CryptoApis.Binance.Futures.V1 do
  @base_url CryptoApis.Binance.Futures.base_url() <> "v1"
  alias CryptoApis.Binance

  def get_futures do
    (@base_url <> "/premiumIndex")
    |> CryptoApis.get()
  end

  def get_future(symbol) do
    (@base_url <> "/premiumIndex")
    |> CryptoApis.get(params: [symbol: symbol])
  end

  def get_funding_rate(opts \\ []) do
    (@base_url <> "/fundingRate")
    |> CryptoApis.get(params: opts)
  end

  def get_exchange_info do
    (@base_url <> "/exchangeInfo")
    |> CryptoApis.get()
  end

  def mark_price do
    (@base_url <> "/premiumIndex")
    |> CryptoApis.get()
  end

  def mark_price(symbol) do
    (@base_url <> "/premiumIndex")
    |> CryptoApis.get(params: [symbol: symbol])
  end

  def get_income_history(api_key, api_secret, params \\ []) do
    (@base_url <> "/income")
    |> CryptoApis.get(
      headers: [{"X-MBX-APIKEY", api_key}],
      params: Binance.build_signature(api_secret, params)
    )
  end

  def get_download_id_for_futures_transaction_history(api_key, api_secret, params \\ []) do
    (@base_url <> "/income/asyn")
    |> CryptoApis.get(
      headers: [{"X-MBX-APIKEY", api_key}],
      params: Binance.build_signature(api_secret, params)
    )
  end

  def get_futures_transaction_history_download_link_by_id(api_key, api_secret, id, params \\ []) do
    (@base_url <> "/income/asyn/id")
    |> CryptoApis.get(
      headers: [{"X-MBX-APIKEY", api_key}],
      params: Binance.build_signature(api_secret, Keyword.put_new(params, :downloadId, id))
    )
  end
end

defmodule CryptoApis.Binance.Futures.V2 do
  @base_url CryptoApis.Binance.Futures.base_url() <> "v2"
  alias CryptoApis.Binance

  def get_current_positions(api_key, api_secret, params \\ []) do
    (@base_url <> "/positionRisk")
    |> CryptoApis.get(
      headers: [{"X-MBX-APIKEY", api_key}],
      params: Binance.build_signature(api_secret, params)
    )
  end
end
