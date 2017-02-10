defmodule Blog.PostControllerTest do
  use Blog.ConnCase, async: true

  import Blog.Factory

  alias Blog.Post

  describe "GET index/2" do
    setup do
      insert_list(5, :post)

      conn = build_conn()
      conn = get conn, post_path(conn, :index)

      [conn: conn]
    end

    test "assigns all posts", %{conn: conn}  do
      assert Enum.count(conn.assigns[:posts]) == 5
    end

    test "respond with status OK", %{conn: conn} do
      assert response(conn, 200)
    end
  end

  describe "GET new/2" do
    setup do
      conn = build_conn()
      conn = get conn, post_path(conn, :new)
      [conn: conn]
    end

    test "assigns changeset", %{conn: conn} do
      assert conn.assigns[:changeset] == Post.changeset(%Post{})
    end

    test "respond with status OK", %{conn: conn} do
      assert response(conn, 200)
    end
  end

  describe "POST create/2" do
    setup do
      post_params = %{title: "My Post", body: String.duplicate("a", 50)}

      conn = build_conn()
      conn = post conn, post_path(conn, :create), post: post_params

      [conn: conn, post_params: post_params]
    end

    test "creates a new post", %{post_params: post_params} do
      %Post{title: title, body: body} = Post |> last |> Repo.one

      assert {body, title} == {post_params.body, post_params.title}
    end

    test "respond with status OK", %{conn: conn} do
      assert redirected_to(conn) =~ post_path(conn, :index)
    end
  end

  describe "GET show/2" do
    setup do
      post = insert(:post)

      conn = build_conn()
      conn = get conn, post_path(conn, :show, post)

      [conn: conn, post: post]
    end

    test "assigns the post", %{conn: conn, post: post} do
      assert conn.assigns[:post] == post
    end
  end

  describe "GET edit/2" do
    setup do
      post = insert(:post)

      conn = build_conn()
      conn = get conn, post_path(conn, :edit, post.id)

      [conn: conn, post: post]
    end

    test "assigns changeset", %{conn: conn, post: post} do
      assert conn.assigns[:changeset] == Post.changeset(post)
    end

    test "respond with status OK", %{conn: conn} do
      assert response(conn, 200)
    end
  end

  describe "PUT update/2" do
    setup do
      post = insert(:post)

      post_params = %{title: "Edited Post", body: String.duplicate("b", 50)}

      conn = build_conn()
      conn = put conn, post_path(conn, :update, post), %{post: post_params}

      [conn: conn, post: post]
    end

    test "updates the post", %{post: post} do
      updated_post = Repo.get(Post, post.id)
      assert {updated_post.title, updated_post.body} == {"Edited Post", String.duplicate("b", 50)}
    end

    test "sets the flash", %{conn: conn} do
      assert get_flash(conn, :info) == "Post was updated successfully."
    end

    test "redirects to post", %{conn: conn, post: post} do
      assert redirected_to(conn) =~  post_path(conn, :show, post)
    end
  end

  describe "DELETE destroy/2" do
    setup do
      post = insert(:post)

      conn = build_conn()
      conn = delete conn, post_path(conn, :delete, post)

      [conn: conn, post: post]
    end

    test "deletes the post", %{post: post} do
      assert is_nil(Repo.get(Post, post.id))
    end

    test "sets flash", %{conn: conn} do
      assert get_flash(conn, :info) == "Post was deleted successfully."
    end

    test "redirects to post index page", %{conn: conn} do
      assert redirected_to(conn) =~ post_path(conn, :index)
    end
  end
end
