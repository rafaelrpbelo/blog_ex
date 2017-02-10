defmodule Blog.Post do
  use Blog.Web, :model

  @required_fields [:title, :body]

  schema "posts" do
    field :title
    field :body

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:body, min: 50)
    |> validate_title_length
  end

  defp validate_title_length(changeset) do
    changeset
    |> validate_length(:title, min: 5)
    |> validate_length(:title, max: 150)
  end
end
