defmodule Cover.StoreTest do
  use Cover.DataCase

  alias Cover.Store

  describe "categories" do
    alias Cover.Store.Category

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Store.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Store.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Store.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Store.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, category} = Store.update_category(category, @update_attrs)
      assert %Category{} = category
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_category(category, @invalid_attrs)
      assert category == Store.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Store.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Store.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Store.change_category(category)
    end
  end

  describe "products" do
    alias Cover.Store.Product

    @valid_attrs %{description: "some description", name: "some name", price: 42, sku: "some sku"}
    @update_attrs %{description: "some updated description", name: "some updated name", price: 43, sku: "some updated sku"}
    @invalid_attrs %{description: nil, name: nil, price: nil, sku: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Store.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Store.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Store.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Store.create_product(@valid_attrs)
      assert product.description == "some description"
      assert product.name == "some name"
      assert product.price == 42
      assert product.sku == "some sku"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, product} = Store.update_product(product, @update_attrs)
      assert %Product{} = product
      assert product.description == "some updated description"
      assert product.name == "some updated name"
      assert product.price == 43
      assert product.sku == "some updated sku"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_product(product, @invalid_attrs)
      assert product == Store.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Store.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Store.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Store.change_product(product)
    end
  end
end
