defmodule CryptoApis.Utils do
  def split_pair(pair) do
    "#{pair}" |> String.split_at(-3)
  end

  def pair_to_tuple({_, _} = pair), do: pair
  def pair_to_tuple(pair), do: split_pair(pair)
  def pair_from_tuple(pair, sep \\ "")
  def pair_from_tuple({crypto, fiat}, sep), do: "#{crypto}#{sep}#{fiat}"
  def pair_from_tuple(pair, _sep), do: "#{pair}"
end
