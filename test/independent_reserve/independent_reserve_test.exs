defmodule CryptoApis.IndependentReserveTest do
  use ExUnit.Case
  import Mock
  alias CryptoApis.IndependentReserve
  import CryptoApis.Fixtures

  describe "order_book" do
    test "order_book/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.order_book(:BTCAUS)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetOrderBook"

        assert response.request.options == [
                 params: [primaryCurrencyCode: "xbt", secondaryCurrencyCode: "aus"]
               ]
      end
    end
  end

  describe "market_summary" do
    test "market_summary/1 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.market_summary(:BTCAUS)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetMarketSummary"

        assert response.request.options == [
                 params: [primaryCurrencyCode: "xbt", secondaryCurrencyCode: "aus"]
               ]
      end
    end
  end

  describe "trade_history" do
    test "trade_history/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.trade_history(:BTCAUS, 1)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetTradeHistorySummary"

        assert response.request.options == [
                 params: [
                   primaryCurrencyCode: "xbt",
                   secondaryCurrencyCode: "aus",
                   numberOfHoursInThePastToRetrieve: 1
                 ]
               ]
      end
    end
  end

  describe "recent_trades" do
    test "recent_trades/2 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.recent_trades(:BTCAUS, 1)
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetRecentTrades"

        assert response.request.options == [
                 params: [
                   primaryCurrencyCode: "xbt",
                   secondaryCurrencyCode: "aus",
                   numberOfRecentTradesToRetrieve: 1
                 ]
               ]
      end
    end
  end

  describe "cryptos" do
    test "cryptos/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.cryptos()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetValidPrimaryCurrencyCodes"
      end
    end
  end

  describe "fiats" do
    test "fiats/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.fiats()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetValidSecondaryCurrencyCodes"
      end
    end
  end

  describe "limit_order_types" do
    test "limit_order_types/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.limit_order_types()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetValidLimitOrderTypes"
      end
    end

    test "market_order_types/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.market_order_types()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetValidMarketOrderTypes"
      end
    end

    test "transaction_types/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.transaction_types()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetValidTransactionTypes"
      end
    end
  end

  describe "market_order_types" do
    test "market_order_types/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.market_order_types()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetValidMarketOrderTypes"
      end
    end
  end

  describe "transaction_types" do
    test "transaction_types/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.transaction_types()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetValidTransactionTypes"
      end
    end
  end

  describe "fx_rates" do
    test "fx_rates/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.fx_rates()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetFxRates"
      end
    end
  end

  describe "minimum_volumes" do
    test "minimum_volumes/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.minimum_volumes()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetOrderMinimumVolumes"
      end
    end
  end

  describe "withdrawal_fees" do
    test "withdrawal_fees/0 responds ok" do
      with_mock HTTPoison,
        get: fn url, _headers, options ->
          {:ok, successful_response(url: url, options: options)}
        end do
        assert {:ok, response} = IndependentReserve.withdrawal_fees()
        assert response.status_code == 200

        assert response.request_url ==
                 "https://api.independentreserve.com/Public/GetCryptoWithdrawalFees"
      end
    end
  end
end
