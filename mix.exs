defmodule OledComparison.MixProject do
  use Mix.Project

  def project do
    [
      app: :oled_comparison,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {OledComparison.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:pngex, "~> 0.1.1"},

      # (un-)comment the following line to load the fixed or original code
      # {:oled, git: "https://github.com/udoschneider/oled.git", branch: "fix-13-14_linedrawing", override: true},

      {:oled_virtual, "~> 1.0"},
    ]
  end
end
