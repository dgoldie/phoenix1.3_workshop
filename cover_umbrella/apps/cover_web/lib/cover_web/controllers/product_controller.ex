defmodule CoverWeb.ProductController do
  use CoverWeb, :controller

  alias Cover.Store
  alias Cover.Store.Product

  def action(conn, _) do
    category = Store.get_category!(conn.params["category_id"])
    args = [conn, conn.params, category]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, category) do
    products = Store.list_products(category)
    render(conn, "index.html", products: products, category: category)
  end

  def new(conn, _params, category) do
    changeset =
      %Product{category_id: category.id}
      |> Store.change_product
    render(conn, "new.html", changeset: changeset, category: category)
  end

  def create(conn, %{"product" => product_params}, category) do
    product_params =
      product_params
      |> Map.put("category_id", category.id)

    case Store.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: category_product_path(conn, :show, category, product))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, category: category)
    end
  end

  def show(conn, %{"id" => id}, category) do
    product = Store.get_product!(category, id)
    render(conn, "show.html", product: product, category: category)
  end

  def edit(conn, %{"id" => id}, category) do
    product = Store.get_product!(category, id)
    changeset = Store.change_product(product)
    render(conn, "edit.html", product: product, changeset: changeset, category: category)
  end

  def update(conn, %{"id" => id, "product" => product_params}, category) do
    product = Store.get_product!(category, id)

    case Store.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: category_product_path(conn, :show, category, product))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset, category: category)
    end
  end

  def delete(conn, %{"id" => id}, category) do
    product = Store.get_product!(category, id)
    {:ok, _product} = Store.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: category_product_path(conn, :index, category))
  end
end
