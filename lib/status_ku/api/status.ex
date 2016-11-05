defmodule StatusKu.API.Status do
  @moduledoc """
  Provides an interface for interacting with the Heroku status API.
  """

  import StatusKu.API.Base

  def current_status do
    {:ok, request(:get, "/current-status") |> StatusKu.Parser.parse_status}
  end

  def issue(id) do
    {:ok, request(:get, "/issues/#{id}") |> StatusKu.Parser.parse_single_issue}
  end

  def issues(params \\ %{}) do
    {:ok, request(:get, "/issues", params) |> StatusKu.Parser.parse_multiple_issues}
  end
end
