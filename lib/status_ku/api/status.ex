defmodule StatusKu.API.Status do
  @moduledoc """
  Provides an interface for interacting with the Heroku status API.
  """

  import StatusKu.API.Base

  @doc """
  Retrieve the current status.
  """
  def current_status do
    request(:get, "/current-status")
    |> StatusKu.Parser.parse_status
  end

  @doc """
  Retrieve a specific issue.
  """
  def issue(id) do
    request(:get, "/issues/#{id}")
    |> StatusKu.Parser.parse_single_issue
  end

  @doc """
  Retrieve a list of issues.
  """
  def issues(params \\ %{}) do
    request(:get, "/issues", params)
    |> StatusKu.Parser.parse_multiple_issues
  end
end
