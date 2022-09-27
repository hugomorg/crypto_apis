Mox.defmock(CryptoApis.HTTPClient.Mock, for: CryptoApis.HTTPClient)
Application.put_env(:crypto_apis, :http_client, CryptoApis.HTTPClient.Mock)
Code.require_file("fixtures/fixtures.ex", __DIR__)
ExUnit.start()
