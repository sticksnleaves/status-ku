defmodule StatusKu.Model.Update do
  defstruct [:contents, :created_at, :id, :incident_id, :status_dev,
             :status_prod, :title, :update_type, :updated_at]
end
