defmodule PhxApp.Frontend.React do
  use Mix.Task

  def run([_args, assets_dir]) do
    Mix.Shell.IO.info([:cyan, "Setting up React stuff"])
    Mix.Shell.IO.info([:green, "Adding React stuff to #{assets_dir}"])
    PhxApp.File.copy_directory(
      PhxApp.Directory.react_assets(),
      assets_dir
    )

    "mv #{assets_dir}/dot_babelrc #{assets_dir}/.babelrc"
    |> Mix.Shell.IO.cmd

    cwd = File.cwd!
    File.cd(assets_dir)
    Mix.Shell.IO.info([:cyan, "Running npm i"])
    Mix.Shell.IO.cmd("npm i")
    File.cd(cwd)
    add_elm_gitignores()
  end


  def add_gitignores do
    [
      "assets/node_modules"
    ]
    |> Enum.each(fn path ->
      Mix.Shell.IO.cmd("echo '#{path}' >> .gitignore")
    end)
  end
end
