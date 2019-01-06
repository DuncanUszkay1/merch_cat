defmodule MerchCatWeb.Router do
  use MerchCatWeb, :router

  import MerchCatWeb.Plugs.Shopify

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

  pipeline :shopify_webhook do
    plug :verify_body_hmac
    plug :load_shop
  end

  pipeline :shopify do
    plug :verify_query_hmac
  end

  scope "/", MerchCatWeb do
    pipe_through :browser

    get "/shops/new", ShopController, :new
    post "/shops/signup", ShopController, :signup
    get "/shops/:id", ShopController, :show
    get "/auth", AuthController, :shopify
    get "/", AdminController, :discord_ping
  end

  scope "/api", MerchCatWeb do
    pipe_through :api

    get "/admin/discord/ping", AdminController, :discord_ping

    scope "/shopify", Shopify do
      pipe_through :shopify
      get "/advertise/discord", AdvertiseController, :discord
    end
  end

  scope "/webhooks", MerchCatWeb do
    pipe_through :api

    scope "/shopify", Shopify do
      pipe_through :shopify_webhook
      post "/", WebhookController, :shopify
    end
  end
end
