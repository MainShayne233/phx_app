defmodule PhxApp.Directory do


  defdelegate package_dot_json(args), to: __MODULE__, as: :assets
  defdelegate webpack(args), to: __MODULE__, as: :assets


  def assets(args) do
    args
    |> PhxApp.Version.for
    |> case do
      1.2 -> "."
      1.3 -> "./assets"
    end
  end
end
