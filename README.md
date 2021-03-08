# Crypto APIs

This project is meant to offer the user a helpful wrapper around various cryptocurrency exchange APIs, so you don't have to worry about the low-level details.

Pair can be any one of the following formats (using "BTCUSD" as an example):

```elixir
  {:BTC, :USD}
  {:BTC, "USD"}
  {"BTC", :USD}
  "BTCUSD"
  :BTCUSD
```

## Currently supported exchanges:

### BitcoinVN (public only)

- `history(opts \\ [])`
- `prices(opts \\ [])`
- `volume(currency, timeframe, opts \\ [])`
- `bank_accounts(opts \\ [])`
- `constraints(opts \\ [])`

### Bitflyer (public only)

- `order_book(pair, opts \\ [])`
- `ticker(pair, opts \\ [])`
- `trades(pair, params \\ [], opts \\ [])`
- `markets(opts \\ [])`
- `order_book_status(opts \\ [])`
- `exchange_status(opts \\ [])`
- `chats(params \\ [], opts \\ [])`

### Bithumb (public only)

- `order_book(pair, opts \\ [])`
- `ticker(pair, opts \\ [])`
- `trades(pair, opts \\ [])`
- `asset_status(crypto, opts \\ [])`
- `btci(opts \\ [])`

### Bitkub (public only)

- `order_book(pair, limit \\ 100, opts \\ [])`
- `bids(pair, limit \\ 100, opts \\ [])`
- `asks(pair, limit \\ 100, opts \\ [])`
- `ticker(pair \\ nil, opts \\ [])`
- `trades(pair, limit \\ 100, opts \\ [])`
- `depth(pair, limit \\ 100, opts \\ [])`
- `status(opts \\ [])`
- `server_time(opts \\ [])`
- `symbols(opts \\ [])`

### Bitstamp (public only)

- `order_book(pair, opts \\ [])`
- `ticker(pair, opts \\ [])`
- `hourly_ticker(pair, opts \\ [])`
- `trades(pair, opts \\ [])`
- `pairs(opts \\ [])`
- `ohlc(pair, params \\ [], opts \\ [])`

### Coinbase (public only)

- `order_book(pair, level \\ nil, opts \\ [])`
- `ticker(pair, opts \\ [])`
- `trades(pair, opts \\ [])`
- `pairs(opts \\ [])`
- `pair(pair, opts \\ [])`
- `historic_rates(pair, opts \\ [])`
- `stats_24h(pair, opts \\ [])`
- `currencies(opts \\ [])`
- `currency(code, opts \\ [])`
- `server_time(opts \\ [])`

### Coinfloor (public only)

- `order_book(pair, opts \\ [])`
- `ticker(pair, opts \\ [])`
- `trades(pair, time \\ nil, opts \\ [])`

### CoinsPH (public only)

- `rates(pair \\ nil, region \\ nil, opts \\ [])`

### Cryptomkt (public only)

- `order_book(pair, order_type, params \\ [], opts \\ [])`
- `ticker(pair, opts \\ [])`
- `trades(pair, params \\ [], opts \\ [])`
- `markets(opts \\ [])`
- `prices(pair, timeframe, params \\ [], opts \\ [])`

### Independent Reserve (public only)

- `order_book(pair, opts \\ [])`
- `market_summary(pair, opts \\ [])`
- `all_orders(pair, opts \\ [])`
- `recent_trades(pair, num_trades, opts \\ [])`
- `trade_history(pair, hours_in_past, opts \\ [])`
- `cryptos(opts \\ [])`
- `fiats(opts \\ [])`
- `limit_order_types(opts \\ [])`
- `market_order_types(opts \\ [])`
- `order_types(opts \\ [])`
- `transaction_types(opts \\ [])`
- `fx_rates(opts \\ [])`
- `minimum_volumes(opts \\ [])`
- `withdrawal_fees(opts \\ [])`

### Indodax (public only)

- `order_book(pair, opts \\ [])`
- `ticker(pair, opts \\ [])`
- `pairs(opts \\ [])`
- `server_time(opts \\ [])`
- `price_increments(opts \\ [])`
- `summaries(opts \\ [])`
- `ticker_all(opts \\ [])`
- `trades(pair, opts \\ [])`

### Kraken (public only)

- `asset_pairs(opts \\ [])`
- `assets(opts \\ [])`
- `ohlc(pair, opts \\ [])`
- `order_book(pair, opts \\ [])`
- `server_time(opts \\ [])`
- `spread(pair, opts \\ [])`
- `system_status(opts \\ [])`
- `ticker(pair, opts \\ [])`
- `trades(pair, opts \\ [])`

### Nairaex (public only)

- `rates(opts \\ [])`

### Remitano (public only)

- `order_book(pair, params \\ [], opts \\ [])`
- `trades(pair, params \\ [], opts \\ [])`
- `volume(opts \\ [])`
- `currencies(opts \\ [])`
- `markets(opts \\ [])`

## Examples

Under the hood, requests are made with [HTTPoison](https://github.com/edgurgel/httpoison). All requests accept an optional list of `options`, which expects 3 keys, all optional. `headers` and `options` are passed straight through to `HTTPoison`. `params` is merged into `options`.

For convenience, JSON responses are automatically decoded, and any response status code not in the OK range is regarded as an error.

Return values follow typical conventions. For example, `Kraken.assets` should return an `{:ok, response}` or an `{:error, response}` tuple.

```elixir
defmodule YourModule do
  alias CryptoApis.Kraken

  def get_recent_trades(pair) do
    {:ok, response} = Kraken.trades(pair)
    do_something(response.body)
  end
end
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `crypto_apis` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:crypto_apis, "~> 0.1.0"}
  ]
end
```
