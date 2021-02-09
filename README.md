# Crypto APIs

This project is meant to offer the user a helpful wrapper around various cryptocurrency exchange APIs, so you don't have to worry about the low-level details.

## Currently supported exchanges:

- Kraken (public only)

## Examples

Under the hood, requests are made with [HTTPoison](https://github.com/edgurgel/httpoison). All requests accept an optional list of `options`, which expects 3 keys, all optional. `headers` and `options` are passed straight through to `HTTPoison`. `params` is merged into `options`.

For convenience, JSON responses are automatically decoded, and any response status code not in the OK range is regarded as an error.

The `!` at the end of functions follows typical conventions. For example, `Kraken.assets` should return an `{:ok, response}` or an `{:error, response}` tuple whereas `Kraken.assets!` returns the response or raises.

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
