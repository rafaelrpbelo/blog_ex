defmodule Blog.PostView do
  use Blog.Web, :view

  def body_shortner(body) do
    Enum.join([String.slice(body, 0..19), "..."])
  end
end
