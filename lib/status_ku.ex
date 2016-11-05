defmodule StatusKu do
  @moduledoc """
  Provides access to the Heroku status API.
  """

  use Application

  @doc false
  def start(_type, _args) do
    StatusKu.Supervisor.start_link
  end

  @doc """
  Retrieve the current status.

  ## Examples

    StatusKu.current_status
  """
  @spec current_status :: %StatusKu.Model.Status{}
  defdelegate current_status, to: StatusKu.API.Status

  @doc """
  Retrieve a specific issue.

  ## Examples

    StatusKu.issue(604)
  """
  @spec issue(integer | String.t) :: %StatusKu.Model.Issue{}
  defdelegate issue(id), to: StatusKu.API.Status

  @doc """
  Retrieve a list of issues.

  ## Examples

    StatusKu.issues
    StatusKu.issues(limit: 1, page: 1)
  """
  @spec issues(map) :: [%StatusKu.Model.Issue{}]
  defdelegate issues(params \\ %{}), to: StatusKu.API.Status
end
