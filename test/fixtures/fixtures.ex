defmodule CryptoApis.Fixtures do
  def successful_response(opts \\ []) do
    status_code = Keyword.get(opts, :status_code, 200)
    body = Keyword.get(opts, :body)
    headers = Keyword.get(opts, :headers, [])
    options = Keyword.get(opts, :options, [])
    url = Keyword.get(opts, :url, "localhost:4000")

    request = %HTTPoison.Request{
      headers: headers,
      options: options,
      url: url
    }

    %HTTPoison.Response{
      status_code: status_code,
      body: body,
      headers: headers,
      request_url: url,
      request: request
    }
  end

  def error_response(opts \\ []) do
    status_code = Keyword.get(opts, :status_code, 404)
    %HTTPoison.Response{status_code: status_code}
  end
end
