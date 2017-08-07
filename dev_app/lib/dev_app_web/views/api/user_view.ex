defmodule DevAppWeb.Api.UserView do
  use DevAppWeb, :view

  def render("index.json", %{users: users}) do
    %{
      users: Enum.map(users, &user_json/1)
    }
  end

  def render("show.json", %{user: user}) do
    %{
      user: user_json(user)
    }
  end

  def user_json(user) do
    %{
      name: user.name,
      email: user.email,
      bio: user.bio,
      number_of_pets: user.number_of_pets,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
end
