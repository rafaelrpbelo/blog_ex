defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def up do
    create table(:posts) do
      add :title, :string
      add :body, :text

      timestamps()
    end
  end

  def down do
    drop table(:posts)
  end
end
