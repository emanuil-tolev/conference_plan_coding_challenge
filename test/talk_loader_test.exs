defmodule TalkLoaderTest do
  use ExUnit.Case
  doctest TalkLoader

  # Functional test
  test "it creates talk objects from the file" do
    result = TalkLoader.load("data/talks.txt")
    assert result == [
      %Talk{title: "Writing Fast Tests Against Enterprise Rails", duration: 60},
      %Talk{title: "Overdoing it in Python", duration: 45},
      %Talk{title: "Lua for the Masses", duration: 30},
      %Talk{title: "Ruby Errors from Mismatched Gem Versions", duration: 45},
      %Talk{title: "Common Ruby Errors", duration: 45},
      %Talk{title: "Rails for Python Developers", duration: 5},
      %Talk{title: "Communicating Over Distance", duration: 60},
      %Talk{title: "Accounting-Driven Development", duration: 45},
      %Talk{title: "Woah", duration: 30},
      %Talk{title: "Sit Down and Write", duration: 30},
      %Talk{title: "Pair Programming vs Noise", duration: 45},
      %Talk{title: "Rails Magic", duration: 60},
      %Talk{title: "Ruby on Rails: Why We Should Move On", duration: 60},
      %Talk{title: "Clojure Ate Scala (on my project)", duration: 45},
      %Talk{title: "Programming in the Boondocks of Seattle", duration: 30},
      %Talk{title: "Ruby vs. Clojure for Back-End Development", duration: 30},
      %Talk{title: "Ruby on Rails Legacy App Maintenance", duration: 60},
      %Talk{title: "A World Without HackerNews", duration: 30},
      %Talk{title: "User Interface CSS in Rails Apps", duration: 30}
    ]
  end

  test "it returns an error if the file cannot be read" do
    assert TalkLoader.load("missing.file") |> elem(0) == :error
  end

  # Unit Test
  test "#parse_line converts a string into a Talk" do
    assert TalkLoader.parse_line("Writing Fast Tests Against Enterprise Rails 60min") ==
      %Talk{title: "Writing Fast Tests Against Enterprise Rails", duration: 60}
  end

  test "#parse_line converts a lightning talk into a Talk" do
    assert TalkLoader.parse_line("Rails for Python Developers lightning") ==
      %Talk{title: "Rails for Python Developers", duration: 5}
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
