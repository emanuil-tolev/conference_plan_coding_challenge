defmodule Scheduler do
  def schedule(talks, tracks) do
    # Order talks by size into 4 arrays
    #   - 60 minutes = large
    #   - 45 minutes = medium
    #   - 30 minutes = small
    #   - 5 minutes = tiny
    large = filter_by_duration(talks, 60)
    medium = filter_by_duration(talks, 45)
    small = filter_by_duration(talks, 30)
    tiny = filter_by_duration(talks, 5)

    #
    #   For each large (ordered largest to smallest)
    #     for each session
    #       if talk fits in session
    #         place talk in session

    # TODO consider making this whole structure not be a nested set of reduce_while calls
    # so that it is easier to see what's going on. Perhaps write unit tests as we go too.
    tracks = large
      |> Enum.reduce(tracks, fn(talk, acc) -> fit_into_first_available_track(talk, acc) end)

    #
    #   for each session
    #     if smallest talk does not fit, skip the bin
    #     else place largest medium item that fits
    #
    #   for each session without a medium item in reverse order
    #     if the two smallest medium items don't fit => skip
    #     else place smallest remaining small item and the largest small item that fits
    #
    #   for each session
    #     if the smallest remaining item of any size class does not fit => skip
    #     else place the largest item that fits and stay on the session
    #
    #   if any talks remain: error
    #   else return talks

    tracks
  end

  # TODO test
  def filter_by_duration(talks, duration) do
    Enum.filter(talks, fn(t) -> t.duration == duration end)
  end

  #
  #
  #
  #

  # TODO test
  # Find the first session for a track that the talk will fit
  def fit_into_first_available_track(talk, tracks) do
    tracks
      |> Enum.reduce_while(tracks, fn(track, _) -> fit_into_first_available_session(talk, track.sessions) end)
  end

  def fit_into_first_available_session(talk, sessions) do
    #
    # FIXME: this is expecting replace_session to return :halt/:cont, but it doesn't.
    # however, fit_into_session does, so maybe we can get it from there instead
    #
    sessions = sessions
                |> Enum.reduce_while(sessions, fn(session, _) -> replace_session(sessions, session, fit_into_session(talk, session)) end)

    # find a session

    # If we've added the talk to a session, halt the reduce
    if Enum.any?(sessions, fn(session) -> Enum.member?(session.talks, talk) end) do
      {:halt, sessions}
    else
      {:cont, sessions}
    end
  end

  def replace_session(sessions, old_session, new_session) do
    sessions
     |> Enum.map(fn(session) -> if(session == old_session, do: new_session, else: session) end)
  end

  # TODO: halt and cont probably don't want to be here, they're to signal to reduce_while in other functions
  def fit_into_session(talk, session) do
    session_length = Enum.flat_map(session.talks, fn(talk) -> talk[:duration] end) |> Enum.sum()
    if session.duration < session_length + talk.duration do
      %{session | talks: session.talks ++ [talk]}
    else
      session
    end
  end
end
