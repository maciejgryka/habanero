defmodule Habanero.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :habanero,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      name: "Habanero",
      docs: docs(),
      source_url: "https://github.com/maciejgryka/habanero",
      description: description(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.7"},
      {:req, "~> 0.4.8"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Hot-deploy your Phoenix app to a running instance"
  end

  defp docs do
    [
      main: "Habanero",
      source_ref: "v#{@version}",
      source_url: "https://github.com/maciejgryka/habanero",
      extra_section: "GUIDES",
      extras: extras()
    ]
  end

  defp extras do
    [
      "guides/getting_started.md",
    ]
  end

  defp package() do
    [
      maintainers: ["Maciej Gryka"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/maciejgryka/habanero"},
      files: ~w(lib CHANGELOG.md LICENSE.md mix.exs README.md)
    ]
  end
end
