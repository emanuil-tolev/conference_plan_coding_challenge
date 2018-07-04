defmodule TalkTest do
  use ExUnit.Case

  test "it has a duration attribute" do
    assert %Talk{title: '_', duration: 27}.duration == 27
  end

  test "it has a title attribute" do
    assert %Talk{title: 'rusty camel', duration: -1}.title == 'rusty camel'
  end
end
