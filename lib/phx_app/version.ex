defmodule PhxApp.Version do


  def for(args) do
    if "--1.2" in args do
      1.2
    else
      1.3
    end
  end
end
