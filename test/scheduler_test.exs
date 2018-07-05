defmodule SchedulerTest do
  use ExUnit.Case
  doctest Scheduler

  test "given an array of talks, it assigns them to tracks" do
    # TODO how to fixtures, share with talk_loader_test.exs
    talks = [
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

    tracks = [
      %Track{title: "Track 1", sessions: [
          %Session{title: "Morning", start_time: ~T[09:00:00], duration: 180, following_event: "Lunch"},
          %Session{title: "Afternoon", start_time: ~T[13:00:00], duration: 240, following_event: "Networking Event"}
        ]},
      %Track{title: "Track 2", sessions: [
          %Session{title: "Morning", start_time: ~T[09:00:00], duration: 180, following_event: "Lunch"},
          %Session{title: "Afternoon", start_time: ~T[13:00:00], duration: 240, following_event: "Networking Event"}
        ]},
    ]

    scheduled_tracks = [
      %Track{
        title: "Track 1",
        sessions: [
          %Session{title: "Morning", start_time: ~T[09:00:00], duration: 180, following_event: "Lunch", talks: [
            %ScheduledTalk{
              start_time: ~T[09:00:00],
              talk: %Talk{
                title: "Writing Fast Tests Against Enterprise Rails",
                duration: 60}
            },
            %ScheduledTalk{
              start_time: ~T[10:00:00],
              talk: %Talk{
                title: "Overdoing it in Python",
                duration: 45}
            },
            %ScheduledTalk{
              start_time: ~T[10:45:00],
              talk: %Talk{
                title: "Lua for the Masses",
                duration: 30}
            },
            %ScheduledTalk{
              start_time: ~T[11:15:00],
              talk: %Talk{
                title: "Ruby Errors from Mismatched Gem Versions",
                duration: 45}
            }
          ]},
          %Session{title: "Afternoon", start_time: ~T[13:00:00], duration: 240, following_event: "Networking Event", talks: [
            %ScheduledTalk{
              start_time: ~T[13:00:00],
              talk: %Talk{
                title: "Ruby on Rails: Why We Should Move On",
                duration: 60}
            },
            %ScheduledTalk{
              start_time: ~T[14:00:00],
              talk: %Talk{
                title: "Common Ruby Errors",
                duration: 45}
            },
            %ScheduledTalk{
              start_time: ~T[14:45:00],
              talk: %Talk{
                title: "Pair Programming vs Noise",
                duration: 45}
            },
            %ScheduledTalk{
              start_time: ~T[15:30:00],
              talk: %Talk{
                title: "Programming in the Boondocks of Seattle",
                duration: 30}
            },
            %ScheduledTalk{
              start_time: ~T[16:00:00],
              talk: %Talk{
                title: "Ruby vs. Clojure for Back-End Development",
                duration: 30}
            },
            %ScheduledTalk{
              start_time: ~T[16:30:00],
              talk: %Talk{
                title: "User Interface CSS in Rails Apps",
                duration: 30}
            }
          ]}
        ]
      },

      %Track{
        title: "Track 2",
        sessions: [
          %Session{title: "Morning", start_time: ~T[09:00:00], duration: 180, following_event: "Lunch", talks: [
            %ScheduledTalk{
              start_time: ~T[09:00:00],
              talk: %Talk{
                title: "Communicating Over Distance",
                duration: 60}
            },
            %ScheduledTalk{
              start_time: ~T[10:00:00],
              talk: %Talk{
                title: "Rails Magic",
                duration: 60}
            },
            %ScheduledTalk{
              start_time: ~T[11:00:00],
              talk: %Talk{
                title: "Woah",
                duration: 30}
            },
            %ScheduledTalk{
              start_time: ~T[11:30:00],
              talk: %Talk{
                title: "Sit Down and Write",
                duration: 30}
            }
          ]},
          %Session{title: "Afternoon", start_time: ~T[13:00:00], duration: 240, following_event: "Networking Event", talks: [
            %ScheduledTalk{
              start_time: ~T[13:00:00],
              talk: %Talk{
                title: "Accounting-Driven Development",
                duration: 45}
            },
            %ScheduledTalk{
              start_time: ~T[13:45:00],
              talk: %Talk{
                title: "Clojure Ate Scala (on my project)",
                duration: 45}
            },
            %ScheduledTalk{
              start_time: ~T[14:30:00],
              talk: %Talk{
                title: "A World Without HackerNews",
                duration: 30}
            },
            %ScheduledTalk{
              start_time: ~T[15:00:00],
              talk: %Talk{
                title: "Ruby on Rails Legacy App Maintenance",
                duration: 60}
            },
            %ScheduledTalk{
              start_time: ~T[16:00:00],
              talk: %Talk{
                title: "Rails for Python Developers",
                duration: 5}
            }
          ]}
        ]
      }
    ]

    assert Scheduler.schedule(talks, tracks) == scheduled_tracks
  end
end
