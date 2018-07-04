defmodule TalkLoader do
  @moduledoc """
  TODO
  """

  @doc """
  Hello world.

  TODO: how can we mock the file load so the doctest works?
  TODO: examples

  """
  def load(filename) do
    try do
      File.stream!(filename)
          |> Stream.map(&String.trim/1)
          |> Stream.map(&parse_line/1)
          |> Enum.to_list
    rescue
      error -> {:error, error}
    end
  end

  def parse_line(line) do
    regex = ~r/(?<title>.+) (?<duration>(?<minutes>\d+)min|lightning)/

    Regex.named_captures(regex, line)
      |> case do
        nil -> {:error, "Unexpected talk entry format: #{line}"}
        captures -> %Talk{title: captures["title"], duration: extract_duration(captures)}
      end
  end

  # TODO test
  def extract_duration(captures) do
    case captures["duration"] do
      "lightning" -> 5
      _ -> String.to_integer(captures["minutes"])
    end
  end
end
