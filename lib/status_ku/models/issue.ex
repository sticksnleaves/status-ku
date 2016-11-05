defmodule StatusKu.Model.Issue do
  defstruct [:created_at, :full_url, :href, :id, :resolved, :status_dev,
             :status_prod, :title, :upcoming, :updated_at, :updates]
end
