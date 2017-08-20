defmodule Cover.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cover.Accounts.User


  schema "users" do
    field :age, :integer
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :age])
    |> validate_required([:name, :email, :age])
    |> unique_constraint(:email)
  end
end
