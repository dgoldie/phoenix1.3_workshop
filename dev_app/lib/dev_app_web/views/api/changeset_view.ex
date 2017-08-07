defmodule DevAppWeb.Api.ChangesetView do
  use DevAppWeb, :view
  # alias DevApp.ResponseWrapper

  # def translate_errors(changeset) do
  #   case hd(changeset.errors) do
  #     {label, {"has already been taken", _}} ->
  #       "#{label}_taken"
  #     {:password, {"should be at most %{count} character(s)", _}} ->
  #       "password_too_long"
  #     {:password, {"should be at least %{count} character(s)", _}} ->
  #       "password_too_short"
  #     _ ->
  #       :something_went_wrong
  #   end
  # end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end

  # def render("error.json", %{error: message}) do
  #   # ResponseWrapper.error translate_errors(changeset)
  #   %{error: message}
  # end

  def render("404.json", _assigns) do
    %{error: "resource not found"}
  end
end
