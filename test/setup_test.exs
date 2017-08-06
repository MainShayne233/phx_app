defmodule SetupTest do
  use ExUnit.Case, async: false

  @app_name "test_app"

  @tag timeout: :infinity
  test "should be able to setup app with default config with no issue" do
    System.cmd("rm", ["-rf", "~/.mix/archives/phx_new"])
    System.cmd("mix", [
      "archive.install",
      "https://github.com/phoenixframework/archives/raw/master/phx_new.ez",
      "--force"
    ])
    System.cmd("rm", ["-rf", "~/.mix/archives/phx_app*"])
    System.cmd("mix", ["do", "archive.build,", "archive.install", "--force"])
    File.cd!("..")
    System.cmd("rm", ["-rf", @app_name])
    System.cmd("mix", ["phx_app.new", @app_name, "--no-ecto", "--elm"])
    File.cd!(@app_name)
    start_server()
    :timer.sleep(10000)
    {page, 0} = System.cmd("curl", ["localhost:4000"])
    kill_server()
    assert page |> String.contains?("TestApp")
  end

  defp start_server do
    spawn fn ->
      System.cmd("mix", ["phx.server"])
      :os.cmd('mix phx.server')
    end
  end

  defp kill_server do
    "ps"
    |> System.cmd(["-ef"])
    |> elem(0)
    |> String.split("\n")
    |> Enum.filter(&( &1 |> String.contains?("phx.server") ))
    |> Enum.each(fn process ->
      pid =
        process
        |> String.split(" ")
        |> Enum.reject(&( &1 == "" ))
        |> Enum.at(1)
      :os.cmd('kill -9 #{pid}')
    end)
  end
end
