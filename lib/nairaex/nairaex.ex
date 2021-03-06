defmodule CryptoApis.Nairaex do
  @root_url "https://nairaex.com/api"

  def rates(opts \\ []) do
    CryptoApis.get(@root_url <> "/rates", opts)
  end
end
