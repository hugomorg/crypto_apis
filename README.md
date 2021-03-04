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

### BitcoinVN (public only)

- `history(opts \\ [])`
- `prices(opts \\ [])`
- `volume(currency, timeframe, opts \\ [])`

### Bitflyer (public only)

- `order_book(pair, opts \\ [])`
- `ticker(pair, opts \\ [])`
- `trades(pair, opts \\ [])`

### Bithumb (public only)

- `order_book(pair, opts \\ [])`
- `ticker(pair, opts \\ [])`
- `trades(pair, opts \\ [])`

### Bitkub (public only)

- `order_book(pair, limit \\ 100, opts \\ [])`
- `ticker(pair \\ nil, opts \\ [])`
- `trades(pair, limit \\ 100, opts \\ [])`

### Bitstamp (public only)

- `order_book(pair, opts \\ [])`
- `ticker(pair, opts \\ [])`
- `trades(pair, opts \\ [])`

### Coinbase (public only)

- `order_book(pair, level \\ nil, opts \\ [])`
- `ticker(pair, opts \\ [])`
- `trades(pair, opts \\ [])`

### Coinfloor (public only)

- `order_book(pair, opts \\ [])`
- `ticker(pair, opts \\ [])`
- `trades(pair, time \\ nil, opts \\ [])`

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
