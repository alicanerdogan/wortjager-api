defmodule Wortjager.Scorecard.Sanitizer do
  @special_chars %{"ä" => "a", "ö" => "o", "ü" => "u", "ß" => "ss"}
  def apply(string) do
    Enum.reduce(@special_chars, string, &(apply_replace(&2, &1)))
    |> String.trim
  end

  defp apply_replace(string, {char, corresponding_chars}), do: String.replace(string, char, corresponding_chars)
end
