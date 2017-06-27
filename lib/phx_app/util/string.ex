defmodule PhxApp.Util.String do

  def snakecase_to_camelcase(string) do
    string
    |> String.split("_")
    |> Enum.map(&titlize/1)
    |> Enum.join("")
  end


  def titlize(string) do
    [first_char | rest] = string |> String.split("")
    String.upcase(first_char) <> (rest |> Enum.join("") |> String.downcase)
  end
end
