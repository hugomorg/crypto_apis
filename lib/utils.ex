defmodule CryptoApis.Utils do
  def split_pair(pair) do
    "#{pair}" |> String.split_at(-3)
  end
end
