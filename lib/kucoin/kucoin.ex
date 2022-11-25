defmodule CryptoApis.Kucoin do
  @base_url "https://api-futures.kucoin.com/api/v1"

  def get_current_funding_rate(symbol) do
    (@base_url <> "/funding-rate/#{symbol}/current") |> CryptoApis.get() |> parse_client_error
  end

  def get_open_contracts_list do
    (@base_url <> "/contracts/active") |> CryptoApis.get()
  end

  def get_current_mark_price(symbol) do
    (@base_url <> "/mark-price/#{symbol}/current") |> CryptoApis.get() |> parse_client_error
  end

  defp parse_client_error(response) do
    case response do
      {:ok, %{body: %{"data" => %{"value" => _value}}}} = ok_response -> ok_response
      {:ok, not_supported} -> {:error, not_supported}
      {:error, _reason} = error -> error
    end
  end
end
