defmodule Auditor.Diff do
  def changes(item, changes), do: do_diff(item |> from_struct?(), changes |> from_struct?())

  defp do_diff(item, changes) do
    item
    |> Differ.diff(changes)
    |> process_changes()
  end

  defp process_changes([]), do: []

  defp process_changes([{key, action, value} | changes]) do
    [
      %Auditor.Change{key: key, action: action, value: process_value(value)}
      | process_changes(changes)
    ]
  end

  defp process_value([]), do: []

  defp process_value([{key, action, value} | values]) do
    [
      %Auditor.Change{key: key, action: action, value: process_value(value)}
      | process_value(values)
    ]
  end

  defp process_value(list) when is_list(list) do
    list
    |> Enum.into(%{})
  end

  defp process_value(value), do: value

  defp from_struct?(map) do
    map
    |> Map.from_struct()
  rescue
    _ -> map
  end
end
