defmodule AcceptanceTest do
  use ExUnit.Case

  @tag :skip
  doctest Confyplan

  @tag :skip
  test "it outputs the conference schedule" do
    assert Confyplan.run() == """
                              Track 1:
                              09:00AM Practical Web Animation
                              10:00AM New Chrome DevTools
                              10:45AM Web Performance
                              11:15AM React, Vue and Angular
                              12:00PM Lunch
                              01:00PM Learning New Languages
                              02:00PM Common Developer Mistakes
                              02:45PM Levelling Up Pair Programming
                              03:30PM How To Start A Community Group
                              04:00PM Building Security Into Code
                              04:30PM UX Is Still A Thing
                              05:00PM Networking Event

                              Track 2:
                              09:00AM Working Remotely
                              10:00AM Why Rails Is Still Relevant
                              11:00AM Security Is Not A Pro Feature
                              11:30AM Raspberry Pi antics
                              12:00PM Lunch
                              01:00PM How We Spammed The World
                              01:45PM Tests Are Important
                              02:30PM Browser Performance
                              03:00PM BDD
                              04:00PM How To Read Hacker News
                              05:00PM Networking Event
                              """
  end
end
