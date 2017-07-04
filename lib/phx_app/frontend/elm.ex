defmodule PhxApp.Frontend.Elm do
  use Mix.Task


  def run([_args, assets_dir]) do
    Mix.Shell.IO.info([:cyan, "Setting up Elm stuff"])
    copy_assets(assets_dir)
    install_dependencies(assets_dir)
    add_elm_gitignores()
  end


  defp copy_assets(assets_dir) do
    Mix.Shell.IO.info([:green, "Adding Elm stuff to #{assets_dir}"])
    PhxApp.File.copy_directory(
      PhxApp.Directory.elm_assets(),
      assets_dir
    )
  end


  defp install_dependencies(assets_dir) do
    case System.cmd("which", ["elm"]) do
      {"", 1} ->
        Mix.Shell.IO.info([
          :red, 
          """
          Looks like you don't have Elm installed. 
          You're going to need that. 
          Checkout elm-lang.org
          """
        ])
      _other ->
        cwd = File.cwd!
        File.cd(assets_dir)
        Mix.Shell.IO.info([:cyan, "Running elm package install -y"])
        Mix.Shell.IO.cmd("elm package install -y")
        Mix.Shell.IO.info([:cyan, "Running npm i"])
        Mix.Shell.IO.cmd("npm i")
        File.cd(cwd)
    end
  end


  def add_elm_gitignores do
    [
      "assets/elm-stuff"
    ]
    |> Enum.each(fn path ->
      Mix.Shell.IO.cmd("echo '#{path}' >> .gitignore")
    end)
  end
end
