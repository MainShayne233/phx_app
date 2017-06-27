defmodule PhxApp.Frontend.React do
  use Mix.Task

  def setup(args, assets_dir) do
    PhxApp.File.copy_directory(
      PhxApp.Directory.react_assets(),
      assets_dir
    )

    cwd = File.cwd!
    File.cd(assets_dir)
    Mix.Shell.IO.cmd("npm i")
    File.cd(cwd)
  end
end
