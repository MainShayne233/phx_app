defmodule PhxApp.Frontend.Elm do


  def setup(_args, assets_dir) do
    copy_assets(assets_dir)
    install_dependencies(assets_dir)
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
        Mix.Shell.IO.cmd("npm i")
        Mix.Shell.IO.cmd("elm package install -y")
        File.cd(cwd)
    end
  end


  defp copy_assets(assets_dir) do
    PhxApp.File.copy_directory(
      PhxApp.Directory.elm_assets(),
      assets_dir
    )
  end
end
