defmodule Cover.Store.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cover.Store.{Product, Category}


  schema "products" do
    field :description, :string
    field :name, :string
    field :price, :integer
    field :sku, :string
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(%Product{} = product, attrs) do
    product
    |> cast(attrs, [:name, :description, :price, :sku, :category_id])
    |> validate_required([:name, :description, :price, :sku, :category_id])
    |> unique_constraint(:sku)
  end
end
