defmodule CryptoApis do
  @moduledoc """
  Documentation for `CryptoApis`.
  """

  defp handle_response(
         {_status, %HTTPoison.Response{status_code: status_code, headers: headers} = resp}
       )
       when status_code >= 200 and status_code < 300 do
    if json?(headers), do: parse_json(resp), else: {:ok, resp}
  end

  defp handle_response({_status, %HTTPoison.Response{} = resp}) do
    {:error, resp}
  end

  defp handle_response({:error, _error} = result), do: result

  defp handle_response!(%HTTPoison.Response{status_code: status_code, headers: headers} = resp)
       when status_code >= 200 and status_code < 300 do
    if json?(headers), do: parse_json!(resp), else: resp
  end

  defp handle_response!(%HTTPoison.Response{} = resp) do
    resp
  end

  defp parse_json(%HTTPoison.Response{body: body} = resp) do
    case Jason.decode(body) do
      {:ok, body} -> {:ok, %HTTPoison.Response{resp | body: body}}
      {:error, _error} = result -> result
    end
  end

  defp parse_json!(%HTTPoison.Response{body: body} = resp) do
    %HTTPoison.Response{resp | body: Jason.decode!(body)}
  end

  defp json?(headers) when is_list(headers) do
    Enum.find_value(headers, false, &json_header?/1)
  end

  defp json_header?({"Content-Type", value}) do
    String.contains?(value, "application/json")
  end

  defp json_header?(_value), do: false

  def fetch(url, opts \\ []) when is_binary(url) do
    {options, headers} = get_opts(opts)

    url
    |> HTTPoison.get(headers, options)
    |> handle_response()
  end

  def fetch!(url, opts \\ []) when is_binary(url) do
    {options, headers} = get_opts(opts)

    url
    |> HTTPoison.get!(headers, options)
    |> handle_response!()
  end

  defp get_opts(opts) do
    options = Keyword.get(opts, :options, [])
    headers = Keyword.get(opts, :headers, [])
    {options, headers}
  end
end
