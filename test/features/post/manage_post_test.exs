defmodule Blog.ManagePostTest do
  use Blog.IntegrationCase

  setup do
    navigate_to("/")
  end

  test "must be able to create a post" do
    find_element(:link_text, "New post")
    |> click

    fill_field({:id, "post_title"}, "Lorem Ipsum")
    fill_field({:id, "post_body"}, "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.")

    find_element(:css, "button")
    |> click

    assert page_source() =~ "Post was created successfully."
    assert page_source() =~ "Lorem Ipsum"
    assert page_source() =~ "Lorem Ipsum is simpl..."
  end

  test "must be able to update a post" do
    insert(:post)

    find_element(:link_text, "Posts")
    |> click

    find_element(:link_text, "edit")
    |> click

    fill_field({:id, "post_title"}, "Where does it come from?")
    fill_field({:id, "post_body"}, "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.")

    find_element(:css, "button[type=submit]")
    |> click

    assert page_source() =~ "Post was updated successfully."
    assert page_source() =~ "Where does it come from?"
    assert page_source() =~ "Contrary to popular belief, Lorem Ipsum is not simply random text"
  end

  @tag skip: "Reason: it is missing support to dialog actions by Webdriver"
  test "must be able to delete a post" do
    insert(:post)

    find_element(:link_text, "Posts")
    |> click

    find_element(:link_text, "delete")
    |> click

    :ok = accept_dialog()

    assert page_source() =~ "Post was deleted successfully."
  end
end
