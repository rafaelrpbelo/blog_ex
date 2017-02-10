defmodule Blog.PostTest do
  use Blog.ModelCase

  alias Blog.Post

  @valid_attrs %{title: "Lorem ipsum", body: String.duplicate("A", 50)}
  @invalid_attrs %{}

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = Post.changeset(%Post{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = Post.changeset(%Post{}, @invalid_attrs)
      refute changeset.valid?
    end

    test "title must not have less than 5 characters" do
      changeset = Post.changeset(%Post{}, %{@valid_attrs | title: "Hi"})
      refute changeset.valid?
    end

    test "title must not have more than 150 characters" do
      new_title = String.duplicate("X", 151)

      changeset = Post.changeset(%Post{}, %{@valid_attrs | title: new_title})
      refute changeset.valid?
    end

    test "body must not have less than 50 characters" do
      changeset = Post.changeset(%Post{}, %{@valid_attrs | body: "Too short!"})
      refute changeset.valid?
    end
  end
end
