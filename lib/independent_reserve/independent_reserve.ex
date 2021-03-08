defmodule CryptoApis.IndependentReserve do
  @moduledoc """
  https://www.independentreserve.com/products/api#public-methods
  """

  @root_url "https://api.independentreserve.com/Public"

  alias CryptoApis.Pair

  defp process_pair(pair), do: pair |> Pair.new() |> Pair.to_tuple()
  defp parse_crypto("BTC"), do: "xbt"
  defp parse_crypto(crypto), do: String.downcase(crypto)

  defp get_params(pair, params \\ []) do
    {crypto, fiat} = process_pair(pair)

    [
      params:
        [
          primaryCurrencyCode: parse_crypto(crypto),
          secondaryCurrencyCode: String.downcase(fiat)
        ] ++ params
    ]
  end

  defp get(type, pair, opts) do
    type
    |> url()
    |> CryptoApis.get(opts ++ get_params(pair))
  end

  defp url(:trade_history) do
    @root_url <> "/GetTradeHistorySummary"
  end

  defp url(:recent_trades) do
    @root_url <> "/GetRecentTrades"
  end

  defp url(:orders) do
    @root_url <> "/GetOrderBook"
  end

  defp url(:all_orders) do
    @root_url <> "/GetAllOrders"
  end

  defp url(:market_summary) do
    @root_url <> "/GetMarketSummary"
  end

  defp url(:cryptos) do
    @root_url <> "/GetValidPrimaryCurrencyCodes"
  end

  defp url(:fiats) do
    @root_url <> "/GetValidSecondaryCurrencyCodes"
  end

  defp url(:limit_order_types) do
    @root_url <> "/GetValidLimitOrderTypes"
  end

  defp url(:market_order_types) do
    @root_url <> "/GetValidMarketOrderTypes"
  end

  defp url(:order_types) do
    @root_url <> "/GetValidOrderTypes"
  end

  defp url(:transaction_types) do
    @root_url <> "/GetValidTransactionTypes"
  end

  defp url(:fx_rates) do
    @root_url <> "/GetFxRates"
  end

  defp url(:minimum_volumes) do
    @root_url <> "/GetOrderMinimumVolumes"
  end

  defp url(:withdrawal_fees) do
    @root_url <> "/GetCryptoWithdrawalFees"
  end

  @doc """
  https://www.independentreserve.com/products/api#GetOrderBook
  """
  def order_book(pair, opts \\ []) do
    get(:orders, pair, opts)
  end

  @doc """
  https://www.independentreserve.com/products/api#GetAllOrders
  """
  def all_orders(pair, opts \\ []) do
    get(:all_orders, pair, opts)
  end

  @doc """
  https://www.independentreserve.com/products/api#GetMarketSummary
  """
  def market_summary(pair, opts \\ []) do
    get(:market_summary, pair, opts)
  end

  @doc """
  https://www.independentreserve.com/products/api#GetTradeHistorySummary
  """
  def trade_history(pair, hours_in_past, opts \\ []) do
    get(
      :trade_history,
      pair,
      opts ++ get_params(pair, numberOfHoursInThePastToRetrieve: hours_in_past)
    )
  end

  @doc """
  https://www.independentreserve.com/products/api#GetRecentTrades
  """
  def recent_trades(pair, num_trades, opts \\ []) do
    get(
      :recent_trades,
      pair,
      opts ++ get_params(pair, numberOfRecentTradesToRetrieve: num_trades)
    )
  end

  @doc """
  https://www.independentreserve.com/products/api#GetValidPrimaryCurrencyCodes
  """
  def cryptos(opts \\ []) do
    :cryptos |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://www.independentreserve.com/products/api#GetValidSecondaryCurrencyCodes
  """
  def fiats(opts \\ []) do
    :fiats |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://www.independentreserve.com/products/api#GetValidLimitOrderTypes
  """
  def limit_order_types(opts \\ []) do
    :limit_order_types |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://www.independentreserve.com/products/api#GetValidMarketOrderTypes
  """
  def market_order_types(opts \\ []) do
    :market_order_types |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://www.independentreserve.com/products/api#GetValidOrderTypes
  """
  def order_types(opts \\ []) do
    :order_types |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://www.independentreserve.com/products/api#GetFxRates
  """
  def fx_rates(opts \\ []) do
    :fx_rates |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://www.independentreserve.com/products/api#GetValidTransactionTypes
  """
  def transaction_types(opts \\ []) do
    :transaction_types |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://www.independentreserve.com/products/api#GetOrderMinimumVolumes
  """
  def minimum_volumes(opts \\ []) do
    :minimum_volumes |> url() |> CryptoApis.get(opts)
  end

  @doc """
  https://www.independentreserve.com/products/api#GetCryptoWithdrawalFees
  """
  def withdrawal_fees(opts \\ []) do
    :withdrawal_fees |> url() |> CryptoApis.get(opts)
  end
end
