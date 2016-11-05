defmodule StatusKu do
  use Application

  def start(_type, _args) do
    StatusKu.Supervisor.start_link
  end
end
