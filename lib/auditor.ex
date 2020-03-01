defmodule Auditor do
  @moduledoc """
  Documentation for Auditor.
  """

  @spec log(:delete | :insert, Map.t(), Map.t() | nil) :: {:ok, any} | {:error, any}
  def log(:delete, item, actor), do: log(:delete, item, actor, %{})
  def log(:insert, item, actor), do: log(:insert, item, actor, %{})

  @doc """
    Log an insertion
  """
  @spec log(:delete | :insert | :update, Map.t(), Map.t() | nil, Map.t()) ::
          {:ok, any} | {:error, any}
  def log(:insert, item, actor, _new_item) do
    %Auditor.Entry{
      action: :insert,
      actor: actor,
      subject: item,
      changes: changes?(%{}, item)
    }
    |> Application.get_env(:auditor, :repo).insert()
  end

  @doc """
    Log an deletion
  """
  def log(:delete, item, actor, _new_item) do
    %Auditor.Entry{
      action: :delete,
      actor: actor,
      subject: item,
      original: item
    }
    |> Application.get_env(:auditor, :repo).insert()
  end

  @doc """
    Log an update
  """
  def log(:update, item, actor, new_item) do
    %Auditor.Entry{
      action: :update,
      actor: actor,
      subject: item,
      changes: changes?(item, new_item)
    }
    |> Application.get_env(:auditor, :repo).insert()
  end

  @doc """
    List edits
  """
  @spec changes(Map.t()) :: {:ok, any} | {:error, any}
  def changes(item) do
    item
    |> Application.get_env(:auditor, :repo).all()
  end

  defp changes?(item, new_item), do: Auditor.Diff.changes(item, new_item)
end
