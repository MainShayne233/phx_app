defmodule PhxApp.File do


  def copy_directory(source, destination) do
    System.cmd("cp", ["-r", source, destination])
  end


  def make_directory_unless_exists(path) do
    if File.dir?(path) == false, do: File.mkdir(path)
  end
end

