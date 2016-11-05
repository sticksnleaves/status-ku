defmodule StatusKu.API.Base do
  @moduledoc """
  Provides common functionality for interacting with the Heroku status API.
  """

  @doc """
  Perform an HTTP request.
  """
  def request(method, path, params \\ %{}) do
    case handle_request(method, path, params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        parse(body)
    end
  end

  # private

  defp handle_request(method, path, params) do
    if (method == :get) do
      apply(HTTPoison, method, [request_url(path) <> "?" <> URI.encode_query(params)])
    else
      apply(HTTPoison, method, [request_url(path), params])
    end
  end

  defp parse(json) do
    Poison.decode!(json)
  end

  defp request_url(path) do
    Application.get_env(:status_ku, :base_url) <> path
  end
end
