defmodule Auditor.MixProject do
  use Mix.Project

  @name :auditor
  @version "0.1.0"
  @deps [
    {:differ, "~> 0.1.1"}
  ]

  def project do
    [
      app: @name,
      version: @version,
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: @deps
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end
end
