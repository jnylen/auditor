defmodule Auditor.Entry do
  defstruct action: nil, actor: nil, subject: nil, changes: [], original: %{}
end
