defmodule PhxApp.Mixfile do
  use Mix.Project

  def project do
    [
      app: :phx_app,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package(),
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp package do
    [
      files: ["lib", "priv"]
    ]
  end

  defp deps do
    []
  end
end
