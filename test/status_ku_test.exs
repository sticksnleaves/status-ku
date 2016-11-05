defmodule StatusKuTest do
  use ExUnit.Case, async: true

  setup do
    bypass = Bypass.open(port: 1337)

    {:ok, bypass: bypass}
  end

  test "client can fetch the current status", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      assert conn.request_path == "/current-status"

      Plug.Conn.resp(conn, 200, status_json)
    end

    assert {:ok, status_struct} == StatusKu.current_status
  end

  test "client can fetch a specific issue", %{bypass: bypass} do
    issue_id = 604

    Bypass.expect bypass, fn conn ->
      assert conn.request_path == "/issues/#{issue_id}"

      Plug.Conn.resp(conn, 200, issue_json)
    end

    assert {:ok, issue_struct} == StatusKu.issue(issue_id)
  end

  test "client can fetch a list of issues", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      assert conn.request_path == "/issues"
      assert conn.query_string == "limit=1&page=1"

      Plug.Conn.resp(conn, 200, issues_json)
    end

    assert {:ok, [issue_struct]} == StatusKu.issues(limit: 1, page: 1)
  end

  # private

  defp status_json do
    ~s<{"status":{"Production":"green","Development":"green"},"issues":[#{issue_json}]}>
  end

  defp issue_json do
    ~s<{"created_at":"2014-04-01T17:16:00Z","id":604,"resolved":true,"status_dev":"green","status_prod":"green","title":"Error when deploying certain apps","upcoming":false,"updated_at":"2014-04-02T06:03:49Z","href":"https://status.heroku.com/api/v3/issues/604","full_url":"https://status.heroku.com/incidents/604","updates":[{"contents":"This change was reverted at 7:26 PM PDT (02:26 UTC).","created_at":"2014-04-01T19:26:00Z","id":1961,"incident_id":604,"status_dev":"green","status_prod":"green","title":"Error when deploying certain apps","update_type":"resolved","updated_at":"2014-04-02T06:03:55Z"}]}>
  end

  defp issues_json do
    ~s<[#{issue_json}]>
  end

  defp status_struct do
    %StatusKu.Model.Status{
      production: "green",
      development: "green",
      issues: [issue_struct]
    }
  end

  defp issue_struct do
    %StatusKu.Model.Issue{
      created_at: "2014-04-01T17:16:00Z",
      full_url: "https://status.heroku.com/incidents/604",
      href: "https://status.heroku.com/api/v3/issues/604",
      id: 604,
      resolved: true,
      status_dev: "green",
      status_prod: "green",
      title: "Error when deploying certain apps",
      upcoming: false,
      updated_at: "2014-04-02T06:03:49Z",
      updates: [
        %StatusKu.Model.Update{
          contents: "This change was reverted at 7:26 PM PDT (02:26 UTC).",
          created_at: "2014-04-01T19:26:00Z",
          id: 1961,
          incident_id: 604,
          status_dev: "green",
          status_prod: "green",
          title: "Error when deploying certain apps",
          update_type: "resolved",
          updated_at: "2014-04-02T06:03:55Z"
        }
      ]
    }
  end
end
