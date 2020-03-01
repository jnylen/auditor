# Auditor

Auditor is an audit log tracker for handling changes in a database.

It does not have any ORM requirements other than being pointed at an module that can then proxy the respones to the specific ORM.

## Installation

The package can be installed by adding `auditor` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:auditor, "~> 0.1.0"}
  ]
end
```

Documentation the docs can be found at [https://hexdocs.pm/auditor](https://hexdocs.pm/auditor).
