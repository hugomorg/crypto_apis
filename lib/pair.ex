defmodule CryptoApis.Pair do
  @keys [:fiat, :crypto]
  @enforce_keys @keys
  defstruct @keys
  alias CryptoApis.Pair

  defimpl String.Chars, for: Pair do
    def to_string(%Pair{} = pair) do
      Pair.join(pair)
    end
  end

  def new(crypto, fiat), do: to_pair(crypto, fiat)

  def new(pair) when is_atom(pair) or is_binary(pair) do
    pair |> CryptoApis.Utils.split_pair() |> new
  end

  def new({crypto, fiat}), do: to_pair(crypto, fiat)
  def new(%Pair{} = pair), do: pair
  def new(crypto: crypto, fiat: fiat), do: to_pair(crypto, fiat)
  def new(fiat: fiat, crypto: crypto), do: to_pair(crypto, fiat)
  def new([crypto, fiat]), do: to_pair(crypto, fiat)
  def new(%{crypto: crypto, fiat: fiat}), do: to_pair(crypto, fiat)
  def new(%{"crypto" => crypto, "fiat" => fiat}), do: to_pair(crypto, fiat)

  defp to_pair(crypto, fiat), do: %Pair{crypto: to_string(crypto), fiat: to_string(fiat)}

  def to_tuple(%Pair{crypto: crypto, fiat: fiat}), do: {crypto, fiat}

  def join(%Pair{crypto: crypto, fiat: fiat}, delimiter \\ "") do
    "#{crypto}#{delimiter}#{fiat}"
  end
end
