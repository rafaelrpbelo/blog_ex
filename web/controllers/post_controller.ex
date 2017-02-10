defmodule Blog.PostController do
  use Blog.Web, :controller

  alias Blog.Post

  def index(conn, _params) do
    posts = Repo.all(Post)
    render conn, "index.html", posts: posts
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post was created successfully.")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => post_id}) do
    post = Repo.get(Post, post_id)
    render conn, "show.html", post: post
  end

  def edit(conn, %{"id" => post_id}) do
    post = Repo.get(Post, post_id)
    changeset = Post.changeset(post)

    render conn, "edit.html", changeset: changeset, post: post
  end

  def update(conn, %{"id" => post_id, "post" => post_params}) do
    post = Repo.get(Post, post_id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post was updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset
    end
  end

  def delete(conn, %{"id" => post_id}) do
    post = Repo.get(Post, post_id)

    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post was deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
