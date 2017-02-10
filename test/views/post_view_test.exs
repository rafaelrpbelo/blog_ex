defmodule Blog.PostViewTest do
  use ExUnit.Case, async: true

  alias Blog.PostView

  test "body_shortner/1 returns a string with 20 characters following to ..." do
    shorter_string =
      String.duplicate("A", 50)
      |> PostView.body_shortner

    assert Regex.match?(~r/^A{20}\.{3}/, shorter_string)
  end
end
