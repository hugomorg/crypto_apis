defmodule CryptoApis do
  @moduledoc """
  Documentation for `CryptoApis`.
  """

  defp merge_params(options, opts) do
    option_params = options[:params] || []
    additional_params = opts[:params] || []

    params = Keyword.merge(option_params, additional_params)
    if Enum.empty?(params), do: options, else: options |> Keyword.put(:params, params)
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
    {options, headers} = parse_opts(opts)

    url
    |> CryptoApis.HTTPClient.impl().get(headers, options)
    |> maybe_parse_json(parse_json?)
    |> validate_status(success_status?)
  end

  def post(url, data, opts \\ []) when is_binary(url) do
    {parse_json?, opts} = Keyword.pop(opts, :parse_json?, true)
    {success_status?, opts} = Keyword.pop(opts, :success_status?, &(&1 in 200..299))
    {options, headers} = parse_opts(opts)

    url
    |> CryptoApis.HTTPClient.impl().post(data, headers, options)
    |> maybe_parse_json(parse_json?)
    |> validate_status(success_status?)
  end

  def data(url, opts \\ []) do
    with {:ok, %HTTPoison.Response{body: body}} <- get(url, opts) do
      {:ok, body}
    end
  end

  defp parse_opts(opts) do
    options = Keyword.get(opts, :options, []) |> merge_params(opts)
    headers = Keyword.get(opts, :headers, [])
    {options, headers}
  end

  def hmac(key, data) do
    :hmac
    |> :crypto.mac(:sha256, key, data)
    |> Base.encode16(case: :lower)
  end
end
