defmodule MerchCatWeb.Router do
  use MerchCatWeb, :router

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

  scope "/", MerchCatWeb do
    pipe_through :browser
  end

  scope "/api", MerchCatWeb do
    pipe_through :api

    get "/admin/discord/ping", AdminController, :ping
  end
end
