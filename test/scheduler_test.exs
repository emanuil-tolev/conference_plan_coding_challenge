defmodule SchedulerTest do
  use ExUnit.Case
  doctest Scheduler

  test "given an array of talks, it assigns them to tracks" do
    # TODO how to fixtures, share with talk_loader_test.exs
    talks = [
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
                title: "Practical Web Animation",
                duration: 60}
            },
            %ScheduledTalk{
              start_time: ~T[10:00:00],
              talk: %Talk{
                title: "New Chrome DevTools",
                duration: 45}
            },
            %ScheduledTalk{
              start_time: ~T[10:45:00],
              talk: %Talk{
                title: "Web Performance",
                duration: 30}
            },
            %ScheduledTalk{
              start_time: ~T[11:15:00],
              talk: %Talk{
                title: "React, Vue and Angular",
                duration: 45}
            }
          ]},
          %Session{title: "Afternoon", start_time: ~T[13:00:00], duration: 240, following_event: "Networking Event", talks: [
            %ScheduledTalk{
              start_time: ~T[13:00:00],
              talk: %Talk{
                title: "Learning New Languages",
                duration: 60}
            },
            %ScheduledTalk{
              start_time: ~T[14:00:00],
              talk: %Talk{
                title: "Common Developer Mistakes",
                duration: 45}
            },
            %ScheduledTalk{
              start_time: ~T[14:45:00],
              talk: %Talk{
                title: "Levelling Up Pair Programming",
                duration: 45}
            },
            %ScheduledTalk{
              start_time: ~T[15:30:00],
              talk: %Talk{
                title: "How To Start A Community Group",
                duration: 30}
            },
            %ScheduledTalk{
              start_time: ~T[16:00:00],
              talk: %Talk{
                title: "Building Security Into Code",
                duration: 30}
            },
            %ScheduledTalk{
              start_time: ~T[16:30:00],
              talk: %Talk{
                title: "UX Is Still A Thing",
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
                title: "Working Remotely",
                duration: 60}
            },
            %ScheduledTalk{
              start_time: ~T[10:00:00],
              talk: %Talk{
                title: "Why Rails Is Still Relevant",
                duration: 60}
            },
            %ScheduledTalk{
              start_time: ~T[11:00:00],
              talk: %Talk{
                title: "Security Is Not A Pro Feature",
                duration: 30}
            },
            %ScheduledTalk{
              start_time: ~T[11:30:00],
              talk: %Talk{
                title: "Raspberry Pi antics",
                duration: 30}
            }
          ]},
          %Session{title: "Afternoon", start_time: ~T[13:00:00], duration: 240, following_event: "Networking Event", talks: [
            %ScheduledTalk{
              start_time: ~T[13:00:00],
              talk: %Talk{
                title: "How We Spammed The World",
                duration: 45}
            },
            %ScheduledTalk{
              start_time: ~T[13:45:00],
              talk: %Talk{
                title: "Tests Are Important",
                duration: 45}
            },
            %ScheduledTalk{
              start_time: ~T[14:30:00],
              talk: %Talk{
                title: "Browser Performance",
                duration: 30}
            },
            %ScheduledTalk{
              start_time: ~T[15:00:00],
              talk: %Talk{
                title: "BDD",
                duration: 60}
            },
            %ScheduledTalk{
              start_time: ~T[16:00:00],
              talk: %Talk{
                title: "How To Read Hacker News",
                duration: 5}
            }
          ]}
        ]
      }
    ]

    assert Scheduler.schedule(talks, tracks) == scheduled_tracks
  end
end
