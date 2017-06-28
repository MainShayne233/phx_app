defmodule PhxApp.Directory do


  def app_assets(args) do
    args
    |> PhxApp.Version.for
    |> case do
      1.2 -> "."
      1.3 -> "./assets"
    end
  end


  def static_directory(args) do
    args
    |> PhxApp.Version.for
    |> case do
      1.2 -> "web/"
      1.3 -> "./assets"
    end
  end


  def shared_css do
    phx_app_dir() <> "/priv/shared/assets/css"
  end


  def shared_static do
    phx_app_dir() <> "/priv/shared/assets/static"
  end


  def assets_digest_template do
    phx_app_dir() <> "/priv/tasks/assets.digest.ex"
  end


  def mix_tasks_dir do
    unless File.dir?("./lib/mix/tasks"), do: Mix.Shell.IO.cmd("mkdir -p ./lib/mix/tasks")
    "./lib/mix/tasks"
  end


  def app_assets_digest do
    mix_tasks_dir() <> "/assets.digest.ex"
  end


  def app_html(args, app_name) do
    args
    |> PhxApp.Version.for
    |> case do
      1.2 -> "./web/templates/layout/app.html.eex"
      1.3 -> "./lib/#{app_name}/web/templates/layout/app.html.eex"
    end
  end


  def index_html(args, app_name) do
    args
    |> PhxApp.Version.for
    |> case do
      1.2 -> "./web/templates/page/index.html.eex"
      1.3 -> "./lib/#{app_name}/web/templates/page/index.html.eex"
    end
  end


  def dev_config do
    "./config/dev.exs"
  end


  def react_assets do
    phx_app_dir() <> "/priv/react/assets"
  end


  def elm_assets do
    phx_app_dir() <> "/priv/elm/assets"
  end


  def app_html_template do
    phx_app_dir() <> "/priv/templates/app.html.eex"
  end


  def assets_script do
    phx_app_dir() <> "/priv/templates/assets_script.html.eex"
  end


  defp phx_app_dir do
    Application.app_dir(:phx_app, ".")
  end
end
