# StatusKu

[![Build Status](https://travis-ci.org/sticksnleaves/status-ku.svg?branch=master)](https://travis-ci.org/sticksnleaves/status-ku)

Elixir client for the Heroku status API

## Installation

  1. Add `status_ku` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:status_ku, "~> 1.0.0"}]
    end
    ```

  2. Ensure `status_ku` is started before your application:

    ```elixir
    def application do
      [applications: [:status_ku]]
    end
    ```

## Usage

```elixir
iex> StatusKu.current_status
{:ok, %StatusKu.Model.Status{
  production: "green",
  development: "green",
  issues: []
}}

iex> StatusKu.issue(604)
{:ok, %StatusKu.Model.Issue{
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
}}

iex> StatusKu.issues(limit: 1, page: 1)
{:ok, %StatusKu.Model.Issue{
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
}}
```
