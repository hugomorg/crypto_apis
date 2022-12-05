defmodule CryptoApis.OKX do
  def get_funding_rate(symbol) do
    "https://www.okx.com/api/v5/public/funding-rate?instId=#{symbol}"
    |> CryptoApis.get()
  end

  def get_underlying(type) do
    "https://www.okx.com/api/v5/public/underlying?instType=#{type}"
    |> CryptoApis.get()
  end

  def get_mark_price(type) do
    "https://www.okx.com/api/v5/public/mark-price?instType=#{type}"
    |> CryptoApis.get()
  end
end
