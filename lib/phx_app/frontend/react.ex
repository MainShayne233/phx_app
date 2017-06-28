defmodule PhxApp.Frontend.React do
  use Mix.Task

  def run([args, assets_dir]) do
    Mix.Shell.IO.info([:cyan, "Setting up React stuff"])
    Mix.Shell.IO.info([:green, "Adding React stuff to #{assets_dir}"])
    PhxApp.File.copy_directory(
      PhxApp.Directory.react_assets(),
      assets_dir
    )

    cwd = File.cwd!
    File.cd(assets_dir)
    Mix.Shell.IO.info([:cyan, "Running npm i"])
    Mix.Shell.IO.cmd("npm i")
    File.cd(cwd)
  end
end
