defmodule CryptoApis do
  @moduledoc """
  Documentation for `CryptoApis`.
  """

  def override_params(opts, key, value) do
    params =
      opts
      |> Keyword.get(:params, [])
      |> Keyword.put(key, value)

    Keyword.put(opts, :params, params)
  end

  defp get_params(opts) do
    opts
    |> Keyword.get(:params)
    |> merge_params(opts)
  end

  defp merge_params(params, opts) when is_list(params) or is_map(params) do
    opts
    |> get_and_update_in([:options], &update_params(&1, params))
    |> elem(1)
  end

  defp merge_params(_, opts), do: opts

  defp update_params([_ | _] = options, params) do
    {options, Keyword.put(options, :params, params)}
  end

  defp update_params(opts, params) do
    {opts, [params: params]}
  end

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

  defp parse_json(%HTTPoison.Response{body: body} = resp) do
    case Jason.decode(body) do
      {:ok, body} -> {:ok, %HTTPoison.Response{resp | body: body}}
      {:error, _error} = result -> result
    end
  end

  defp json?(headers) when is_list(headers) do
    Enum.find_value(headers, false, &json_header?/1)
  end

  defp json_header?({"Content-Type", value}) do
    String.contains?(value, "application/json")
  end

  defp json_header?(_value), do: false

  def get(url, opts \\ []) when is_binary(url) do
    {options, headers} = get_opts(opts)

    url
    |> HTTPoison.get(headers, options)
    |> handle_response()
  end

  defp get_opts(opts) do
    options = opts |> get_params |> Keyword.get(:options, [])
    headers = Keyword.get(opts, :headers, [])
    {options, headers}
  end

  def split_pair(pair) do
    "#{pair}" |> String.split_at(-3)
  end
end
