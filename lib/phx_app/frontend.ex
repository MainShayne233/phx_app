defmodule PhxApp.Frontend do

  @frontend_modules [
    {"--react", PhxApp.Frontend.React},
    {"--elm", PhxApp.Frontend.React},
  ]

  @default_frontend_module PhxApp.Frontend.React


  def setup(args) do
    Mix.Shell.IO.info([:cyan, "Setting up frontend."])
    args
    |> frontend_module
    |> apply(:setup, [args])
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
