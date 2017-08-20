defmodule CoverWeb.Router do
  use CoverWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CoverWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/categories", CategoryController do
      resources "/products", ProductController
    end
    # resources "/products", ProductController, except: [:index, :new]

  end

  # Other scopes may use custom stacks.
  # scope "/api", CoverWeb do
  #   pipe_through :api
  # end
end
