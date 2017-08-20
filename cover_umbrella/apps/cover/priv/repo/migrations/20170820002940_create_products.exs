defmodule Cover.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :text
      add :price, :integer
      add :sku, :string
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:products, [:sku])
    create index(:products, [:category_id])
  end
end
