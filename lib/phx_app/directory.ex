defmodule PhxApp.Directory do


  def app_assets do
    "./assets"
  end

  def static_directory do
    "./assets"
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
    unless File.dir?("./lib/mix/tasks") do
      Mix.Shell.IO.cmd("mkdir -p ./lib/mix/tasks")
    end
    "./lib/mix/tasks"
  end

  def app_assets_digest do
    mix_tasks_dir() <> "/assets.digest.ex"
  end

  def app_html(app_name) do
    "./lib/#{app_name}_web/templates/layout/app.html.eex"
  end

  def index_html(app_name) do
    "./lib/#{app_name}_web/templates/page/index.html.eex"
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
