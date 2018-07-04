defmodule Session do
  @enforce_keys [:title, :start_time, :duration, :following_event]
  defstruct [:title, :start_time, :duration, :following_event, talks: []]
end
