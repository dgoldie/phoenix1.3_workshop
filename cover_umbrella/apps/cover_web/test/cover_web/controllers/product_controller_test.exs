defmodule CoverWeb.ProductControllerTest do
  use CoverWeb.ConnCase

  alias Cover.Store

  @create_attrs %{description: "some description", name: "some name", price: 42, sku: "some sku"}
  @update_attrs %{description: "some updated description", name: "some updated name", price: 43, sku: "some updated sku"}
  @invalid_attrs %{description: nil, name: nil, price: nil, sku: nil}

  def fixture(:category) do
    {:ok, category} = Store.create_category(%{name: "catz"})
    category
  end

  def fixture(:product) do
    category = fixture(:category)
    attrs = Map.merge @create_attrs, %{category_id: category.id}
    {:ok, product} = Store.create_product(attrs)
    product
  end

  describe "index" do
    setup [:create_category]

    test "lists all products", %{conn: conn, category: category} do
      conn = get conn, category_product_path(conn, :index, category)
      assert html_response(conn, 200) =~ "Listing Products"
    end
  end

  describe "new product" do
    setup [:create_category]

    test "renders form", %{conn: conn, category: category} do
      conn = get conn, category_product_path(conn, :new, category)
      assert html_response(conn, 200) =~ "New Product"
    end
  end

  describe "create product" do
    setup [:create_category]

    test "redirects to show when data is valid", %{conn: conn, category: category} do

      attrs = Map.merge(@create_attrs, %{category_id: category.id})
      conn = post conn, category_product_path(conn, :create, category), product: attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == category_product_path(conn, :show, category, id)

      conn = get conn, category_product_path(conn, :show, category, id)
      assert html_response(conn, 200) =~ "Show Product"
    end

    test "renders errors when data is invalid", %{conn: conn, category: category} do
      attrs = Map.merge(@invalid_attrs, %{category_id: category.id})
      conn = post conn, category_product_path(conn, :create, category), product: attrs
      assert html_response(conn, 200) =~ "New Product"
    end
  end

  describe "edit product" do
    setup [:create_product]

    test "renders form for editing chosen product", %{conn: conn, product: product} do
      category = Store.get_category!(product.category_id)
      conn = get conn, category_product_path(conn, :edit, category, product)
      assert html_response(conn, 200) =~ "Edit Product"
    end
  end

  describe "update product" do
    setup [:create_product]

    test "redirects when data is valid", %{conn: conn, product: product} do
      category = Store.get_category!(product.category_id)

      conn = put conn, category_product_path(conn, :update, category, product), product: @update_attrs
      assert redirected_to(conn) == category_product_path(conn, :show, category, product)

      conn = get conn, category_product_path(conn, :show, category, product)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      category = Store.get_category!(product.category_id)

      conn = put conn, category_product_path(conn, :update, category, product), product: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Product"
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: conn, product: product} do
      category = Store.get_category!(product.category_id)

      conn = delete conn, category_product_path(conn, :delete, category, product)
      assert redirected_to(conn) == category_product_path(conn, :index, category)
      assert_error_sent 404, fn ->
        get conn, category_product_path(conn, :show, category, product)
      end
    end
  end

  defp create_category(_) do
    category = fixture(:category)
    {:ok, category: category}
  end

  defp create_product(_) do
    product = fixture(:product)
    {:ok, product: product}
  end
end
