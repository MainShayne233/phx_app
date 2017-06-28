defmodule Mix.Tasks.PhxApp.New do
  use Mix.Task

  @phoenix_args [
    "--no-ecto",
    "--no-html",
    "--umbrella",
    "--module",
  ]

  def run([]) do
    """
    Usage:

    mix phx_app.new app_name

    Phoenix options:
      #{ @phoenix_args |> Enum.join("\n") }

    Frontend options:
      --react
      --elm
    """
    |> Mix.shell.info
  end


  def run([app_name | args]) do
    create_phoenix_app(app_name, args)
    File.cd(app_name)
    PhxApp.Frontend.run([args, app_name])
    File.cd("..")
    """
    All done!

    To start your app:
    cd #{app_name}
    #{ecto_message(args)}
    #{start_command(args)}
    
    Then your app should be running at http://localhost:4000
    """
  end


  defp ecto_messsage(args) do
    if "--no-ecto" in args do
      nil
    else
      "\nmix ecto.create # create your database"
    end
  end


  def start_command(args) do
    args
    |> PhxApp.Version.for
    |> case do
      1.2 -> "\nmix phoenix.server"
      1.3 -> "\nmix phx.server"
    end
    |> Kernel.<>(" # start the server")
  end


  defp create_phoenix_app(app_name, args) do
    gen_cmd = phoenix_generator_cmd(args)
    Mix.Shell.IO.info([:cyan, "Running normal #{gen_cmd} command."])
    "echo y | mix #{gen_cmd} #{app_name} #{args |> phoenix_args_for |> Enum.join(" ")}"
    |> Mix.Shell.IO.cmd
    Mix.Shell.IO.info([:cyan, "PSYCH! We still have some more to do."])
  end


  defp phoenix_generator_cmd(args) do
    args
    |> PhxApp.Version.for
    |> case do
      1.2 -> "phoenix.new"
      1.3 -> "phx.new"
    end
  end


  defp phoenix_args_for(args) do
    args
    |> Enum.filter(&( &1 in @phoenix_args ))
    |> Enum.concat(["--no-brunch"])
  end


  def default_args do
    [
      "--react",
    ]
  end
end
