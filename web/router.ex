defmodule SentinelApi.Router do
  @moduledoc """
    Application routes
  """

  use SentinelApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SentinelApi do
    pipe_through ~w(browser browser_auth)a

    get "/", PageController, :index, as: :root

    resources "/users", UserController, only: ~w(index new create)a
    resources "/sessions", SessionController, only: ~w(new create delete)a

    get "/*path", PageController, :index
  end
end
