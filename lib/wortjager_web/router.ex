defmodule WortjagerWeb.Router do
  use WortjagerWeb, :router

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

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated, handler: WortjagerWeb.Token
    plug Guardian.Plug.LoadResource
  end

  scope "/api", WortjagerWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create]
    resources "/sessions", SessionController, only: [:create]
  end

  scope "/api", WortjagerWeb do
    pipe_through [:api, :api_auth]

    resources "/users", UserController, except: [:index, :create, :edit]
    delete "/sessions", SessionController, :logout
  end
end
