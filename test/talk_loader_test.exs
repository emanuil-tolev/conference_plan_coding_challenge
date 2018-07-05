defmodule TalkLoaderTest do
  use ExUnit.Case
  doctest TalkLoader

  # Functional test
  test "it creates talk objects from the file" do
    result = TalkLoader.load("data/talks.txt")
    assert result == [
      %Talk{title: "Practical Web Animation", duration: 60},
      %Talk{title: "New Chrome DevTools", duration: 45},
      %Talk{title: "Web Performance", duration: 30},
      %Talk{title: "React, Vue and Angular", duration: 45},
      %Talk{title: "Common Developer Mistakes", duration: 45},
      %Talk{title: "How To Read Hacker News", duration: 5},
      %Talk{title: "Working Remotely", duration: 60},
      %Talk{title: "How We Spammed The World", duration: 45},
      %Talk{title: "Security Is Not A Pro Feature", duration: 30},
      %Talk{title: "Raspberry Pi antics", duration: 30},
      %Talk{title: "Levelling Up Pair Programming", duration: 45},
      %Talk{title: "Why Rails Is Still Relevant", duration: 60},
      %Talk{title: "Learning New Languages", duration: 60},
      %Talk{title: "Tests Are Important", duration: 45},
      %Talk{title: "How To Start A Community Group", duration: 30},
      %Talk{title: "Building Security Into Code", duration: 30},
      %Talk{title: "BDD", duration: 60},
      %Talk{title: "Browser Performance", duration: 30},
      %Talk{title: "UX Is Still A Thing", duration: 30}
    ]
  end

  test "it returns an error if the file cannot be read" do
    assert TalkLoader.load("missing.file") |> elem(0) == :error
  end

  # Unit Test
  test "#parse_line converts a string into a Talk" do
    assert TalkLoader.parse_line("UX Is Still A Thing 60min") ==
      %Talk{title: "UX Is Still A Thing", duration: 60}
  end

  test "#parse_line converts a lightning talk into a Talk" do
    assert TalkLoader.parse_line("BDD Experts lightning") ==
      %Talk{title: "BDD Experts", duration: 5}
  end

  test "#extract_duration(captures) understands lightning talks" do
    captures = %{"duration" => "lightning"}
    assert TalkLoader.extract_duration(captures) == 5
  end

  test "#extract_duration(captures) extracts talk length" do
    captures = %{"duration" => "45min", "minutes" => "45"}
    assert TalkLoader.extract_duration(captures) == 45
  end
end
