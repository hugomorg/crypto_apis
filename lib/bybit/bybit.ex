defmodule CryptoApis.Bybit do
  def get_last_funding_rate(symbol) do
    "https://api.bybit.com/public/linear/funding/prev-funding-rate?symbol=#{symbol}"
    |> CryptoApis.get()
  end

  def symbols do
    "https://api.bybit.com/v2/public/symbols"
    |> CryptoApis.get()
  end

  def ticker do
    "https://api.bybit.com/v2/public/tickers"
    |> CryptoApis.get()
  end

  def ticker(symbol) do
    "https://api.bybit.com/v2/public/tickers?symbol=#{symbol}"
    |> CryptoApis.get()
  end

  def get_positions(api_key, api_secret, params \\ []) do
    sorted_query_string =
      [
        {:api_key, api_key}
        | Keyword.put_new_lazy(params, :timestamp, fn ->
            DateTime.to_unix(DateTime.utc_now(), :millisecond)
          end)
      ]
      |> Enum.sort()
      |> URI.encode_query()

    signature = CryptoApis.hmac(api_secret, sorted_query_string)

    "https://api.bybit.com/private/linear/position/list?#{sorted_query_string}&sign=#{signature}"
    |> CryptoApis.get()
  end

  def get_last_funding_fee(api_key, api_secret, symbol, params \\ []) do
    sorted_query_string =
      [
        {:api_key, api_key},
        {:symbol, symbol}
        | Keyword.put_new_lazy(params, :timestamp, fn ->
            DateTime.to_unix(DateTime.utc_now(), :millisecond)
          end)
      ]
      |> Enum.sort()
      |> URI.encode_query()

    signature = CryptoApis.hmac(api_secret, sorted_query_string)

    "https://api.bybit.com/private/linear/funding/prev-funding?#{sorted_query_string}&sign=#{signature}"
    |> CryptoApis.get()
  end

  def get_user_trade_records(api_key, api_secret, symbol, params \\ []) do
    sorted_query_string =
      [
        {:api_key, api_key},
        {:symbol, symbol}
        | Keyword.put_new_lazy(params, :timestamp, fn ->
            DateTime.to_unix(DateTime.utc_now(), :millisecond)
          end)
      ]
      |> Enum.sort()
      |> URI.encode_query()

    signature = CryptoApis.hmac(api_secret, sorted_query_string)

    "https://api.bybit.com/contract/v3/private/execution/list?#{sorted_query_string}&sign=#{signature}"
    |> CryptoApis.get()
  end
end
