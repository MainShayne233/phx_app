defmodule Mix.Tasks.PhxApp.New do
  use Mix.Task

  @phoenix_args [
    "--no-ecto",
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
    add_mix_tasks()
    File.cd("..")
    """

    All done!

    To start your app:
    cd #{app_name} #{ecto_message(args)}
    #{start_command()} # start the server
    OR
    iex -S #{start_command()} # start the server with an interactive shell

    Then your app should be running at http://localhost:4000
    """
    |> Mix.Shell.IO.info
  end

  defp ecto_message(args) do
    if "--no-ecto" in args do
      nil
    else
      "\nmix ecto.create # create your database"
    end
  end

  def start_command do
    "mix phx.server"
  end

  defp create_phoenix_app(app_name, args) do
    gen_cmd = phoenix_generator_cmd()
    Mix.Shell.IO.info([:cyan, "Running normal #{gen_cmd} command."])
    "echo y | mix #{gen_cmd} #{app_name} #{args |> phoenix_args_for |> Enum.join(" ")}"
    |> Mix.Shell.IO.cmd
    Mix.Shell.IO.info([:cyan, "PSYCH! We still have some more to do."])
  end

  defp add_mix_tasks do
    Mix.Shell.IO.info([:green, "Create lib/mix/tasks/assets.digest.ex"])
    PhxApp.Directory.app_assets_digest()
    |> File.write!( PhxApp.Directory.assets_digest_template() |> File.read! )
  end

  defp phoenix_generator_cmd do
    "phx.new"
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
