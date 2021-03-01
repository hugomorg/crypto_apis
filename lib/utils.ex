defmodule CryptoApis.Utils do
  def split_pair(pair) do
    "#{pair}" |> String.split_at(-3)
  end

  def override_params(opts, key, value) do
    params =
      opts
      |> Keyword.get(:params, [])
      |> Keyword.put(key, value)

    Keyword.put(opts, :params, params)
  end
end
