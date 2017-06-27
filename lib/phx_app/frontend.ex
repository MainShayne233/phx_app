defmodule PhxApp.Frontend do

  @frontend_modules [
    {"--react", PhxApp.Frontend.React},
    {"--elm", PhxApp.Frontend.Elm},
  ]

  @default_frontend_module PhxApp.Frontend.React


  def setup(args, app_name) do
    Mix.Shell.IO.info([:cyan, "Setting up frontend."])
    create_app_html(args, app_name)
    create_index_html(args, app_name)
    setup_dev_config()
    assets_dir = PhxApp.Directory.app_assets(args)
    args
    |> frontend_module
    |> apply(:setup, [args, assets_dir])
    copy_shared_assets(args, assets_dir)
  end


  defp copy_shared_assets(args, assets_dir) do
    PhxApp.File.copy_directory(
      PhxApp.Directory.shared_css(),
      assets_dir
    )
    PhxApp.File.copy_directory(
      PhxApp.Directory.shared_static(),
      PhxApp.Directory.static_directory(args)
    )
  end


  defp setup_dev_config do
    dev_config_path = PhxApp.Directory.dev_config()
    updated_dev_config =
      dev_config_path
      |> File.read!
      |> String.replace("watchers: []", watchers())
      |> String.replace("~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},", "")

    File.write!(dev_config_path, updated_dev_config)
  end


  defp watchers do
   """
   watchers: [
       node: [
         "./node_modules/.bin/webpack-dev-server", "--watch-stdin", "--colors",
         cd: Path.expand("../assets", __DIR__),
       ]
     ]
   """
  end


  defp create_app_html(args, app_name) do
    app_html = 
      PhxApp.Directory.app_html_template()
      |> EEx.eval_file(
        assigns: [
          app_module_name: PhxApp.Util.String.snakecase_to_camelcase(app_name),
          render_function: "<%= render @view_module, @view_template, assigns %>",
          assets_script_conditional: assets_script_conditional()
        ]
      )
    File.write!(PhxApp.Directory.app_html(args, app_name), app_html)
  end


  defp create_index_html(args, app_name) do
    args
    |> PhxApp.Directory.index_html(app_name)
    |> File.write("<div id=\"root\"></div>")
  end


  def assets_script_conditional do
    [first_line | rest] = 
      PhxApp.Directory.assets_script()
      |> File.read!
      |> String.split("\n")

    adjusted_lines = 
      rest
      |> Enum.map(&( "    " <> &1 ))
      |> Enum.join("\n")

    first_line <> "\n" <> adjusted_lines
  end


  defp frontend_module(args) do
    @frontend_modules
    |> Enum.find(fn {arg, _module} -> arg in args end)
    |> case do
      nil -> @default_frontend_module
      {_arg, module} -> module
    end
  end
end
