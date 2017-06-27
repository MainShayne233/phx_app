defmodule Mix.Tasks.PhxApp.Greeting do
  use Mix.Task

  def run(args) do
    Mix.shell.info [:green, "yo yo yo"]
  end
end
