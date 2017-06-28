defmodule SetupTest do
  use ExUnit.Case, async: false

  @app_name "test_app"

  @tag timeout: :infinity
  test "should be able to setup app with default config with no issue" do
    File.cd!("..")
    :os.cmd('rm -rf #{@app_name}')
    |> IO.inspect
    :os.cmd('mix archive.install github MainShayne233/phx_app --force')
    |> IO.inspect
    :os.cmd('mix phx_app.new #{@app_name} --no-ecto')
    |> IO.inspect
    File.cd!(@app_name)
    start_server()
    :timer.sleep(10000)
    {page, 0} = System.cmd("curl", ["localhost:4000"])
    assert page |> String.contains?("TestApp")
    kill_server()
  end

  defp start_server do
    spawn fn ->
      :os.cmd('mix phx.server')
    end
  end

  defp kill_server do
    "ps"
    |> System.cmd(["-ef"])
    |> elem(0)
    |> String.split("\n")
    |> Enum.filter(&( &1 |> String.contains?("mix phoenix.server") ))
    |> Enum.each(fn process -> 
      pid = process
      |> String.split(" ")
      |> Enum.reject(&( &1 == "" ))
      |> Enum.at(1)
      :os.cmd('kill -9 #{pid}')
    end)
  end
end
