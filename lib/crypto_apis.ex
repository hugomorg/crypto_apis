defmodule CryptoApis do
  @moduledoc """
  Documentation for `CryptoApis`.
  """

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

  defp maybe_parse_json({:ok, %HTTPoison.Response{headers: headers} = resp}, true) do
    if json?(headers) do
      parse_json(resp)
    else
      {:ok, resp}
    end
  end

  defp maybe_parse_json(resp, _), do: resp

  defp validate_status(
         {:ok, %HTTPoison.Response{status_code: status_code} = resp} = result,
         success_status?
       )
       when is_function(success_status?, 1) do
    if success_status?.(status_code) do
      result
    else
      {:error, resp}
    end
  end

  defp validate_status(resp, _), do: resp

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
    {parse_json?, opts} = Keyword.pop(opts, :parse_json?, true)
    {success_status?, opts} = Keyword.pop(opts, :success_status?, &(&1 in 200..299))
    {options, headers} = get_opts(opts)

    url
    |> HTTPoison.get(headers, options)
    |> maybe_parse_json(parse_json?)
    |> validate_status(success_status?)
  end

  defp get_opts(opts) do
    options = opts |> get_params |> Keyword.get(:options, [])
    headers = Keyword.get(opts, :headers, [])
    {options, headers}
  end
end
