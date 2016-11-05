defmodule StatusKu.Parser do
  def parse_multiple_issues(list) do
    struct_from_list(list, as: %StatusKu.Model.Issue{updates: [%StatusKu.Model.Update{}]})
  end

  def parse_single_issue(map) do
    struct_from_map(map, as: %StatusKu.Model.Issue{updates: [%StatusKu.Model.Update{}]})
  end

  def parse_status(map) do
    issues = map["issues"]
    status = map["status"]

    %StatusKu.Model.Status{development: status["Development"],
                           production: status["Production"],
                           issues: parse_multiple_issues(issues)}
  end

  # private

  defp struct_from_list(list, as: struct) do
    for map <- list, into: [] do
      struct_from_map(map, as: struct)
    end
  end

  defp struct_from_map(map, as: struct) do
    struct_keys = Map.keys(struct) |> Enum.filter(fn x -> x != :__struct__ end)

    processed_map =
      for key <- struct_keys, into: %{} do
        value = Map.get(map, key) || Map.get(map, to_string(key))
        struct_value = Map.get(struct, key)

        cond do
          (is_list(struct_value) && is_list(value)) ->
            {key, struct_from_list(value, as: Enum.at(struct_value, 0))}
          (is_map(struct_value) && is_map(value)) ->
            {key, struct_from_map(value, as: struct_value)}
          true ->
            {key, value}
        end
      end

    Map.merge(struct, processed_map)
  end
end
