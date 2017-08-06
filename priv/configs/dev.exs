use Mix.Config

config :<%= @app_name %>, UltimatePhoenixBoilerplate.Web.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
   watchers: [
     node: [
       "./node_modules/.bin/webpack-dev-server", "--watch-stdin", "--colors",
       cd: Path.expand("../assets", __DIR__),
     ]
   ]

config :<%= @app_name %>, UltimatePhoenixBoilerplate.Web.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/gettext/.*(po)$},
      ~r{lib/<%= @app_name %>_web/views/.*(ex)$},
      ~r{lib/<%= @app_name %>_web/templates/.*(eex)$}
    ]
  ]

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :<%= @app_name %>, UltimatePhoenixBoilerplate.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "<%= @app_name %>_dev",
  hostname: "localhost",
  pool_size: 10



import_config "setup.exs"
