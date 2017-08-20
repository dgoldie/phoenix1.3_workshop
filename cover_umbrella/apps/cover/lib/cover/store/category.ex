defmodule Cover.Store.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cover.Store.{Category, Product}


  schema "categories" do
    field :name, :string
    has_many :products, Product

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
