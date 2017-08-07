defmodule DevAppWeb.Api.FallbackController do
  use DevAppWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(DevAppWeb.Api.ChangesetView, "error.json", changeset: changeset)
  end

  # def call(conn, {:error, message}) do
  #   conn
  #   |> put_status(:unprocessable_entity)
  #   |> render(DevAppWeb.Api.ChangesetView, "error.json", error: message)
  # end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(DevAppWeb.Api.ChangesetView, :"404")
  end

  #
end
