defmodule DevAppWeb.Api.UserController do
  use DevAppWeb, :controller

  alias DevApp.Accounts
  alias DevApp.Accounts.User

  action_fallback DevAppWeb.Api.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params),
    do: render(conn, "show.json", user: user)
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Accounts.get_user(id),
    do: render(conn, "show.json", user: user)
  end


  # def create(conn, %{"user" => user_params}) do
  #   case Accounts.create_user(user_params) do
  #     {:ok, user} ->
  #       conn
  #       |> put_flash(:info, "User created successfully.")
  #       |> redirect(to: user_path(conn, :show, user))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

#   def show(conn, %{"id" => id}) do
#     user = Accounts.get_user!(id)
#     render(conn, "show.html", user: user, current_path: current_url(conn))
#   end

#   def edit(conn, %{"id" => id}) do
#     user = Accounts.get_user!(id)
#     changeset = Accounts.change_user(user)
#     render(conn, "edit.html", user: user, changeset: changeset)
#   end

#   def update(conn, %{"id" => id, "user" => user_params}) do
#     user = Accounts.get_user!(id)

#     case Accounts.update_user(user, user_params) do
#       {:ok, user} ->
#         conn
#         |> put_flash(:info, "User updated successfully.")
#         |> redirect(to: user_path(conn, :show, user))
#       {:error, %Ecto.Changeset{} = changeset} ->
#         render(conn, "edit.html", user: user, changeset: changeset)
#     end
#   end

#   def delete(conn, %{"id" => id}) do
#     user = Accounts.get_user!(id)
#     {:ok, _user} = Accounts.delete_user(user)

#     conn
#     |> put_flash(:info, "User deleted successfully.")
#     |> redirect(to: user_path(conn, :index))
#   end
end
