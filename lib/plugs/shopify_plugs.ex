defmodule MerchCatWeb.Plugs.Shopify do
  import Plug.Conn

  require Logger

  alias MerchCat.ShopifyApp

  def verify_query_hmac(conn, _) do
    {hmac, query} = conn |> separate_query_hmac
    secret = System.get_env("SHOPIFY_API_SECRET")
    conn
    |> verify_hmac(secret, query, hmac)
  end

  def verify_body_hmac(conn, _) do
    hmac = hd(conn |> get_req_header("x-shopify-hmac-sha256"))
    secret = System.get_env("SHOPIFY_TEMP_WEBHOOK_SECRET")
    body = conn.private[:copied_body]
    conn
    |> verify_hmac(secret, body, hmac)
  end

  def load_shop(conn, _) do
    shopify_domain = conn |> get_req_header("x-shopify-shop-domain") |> hd
    shop = ShopifyApp.get_shop_by(:shopify_domain, shopify_domain)
    conn |> put_private(:shop, shop)
  end

  defp verify_hmac(conn, secret, data, hmac) do
    if Base.encode16(:crypto.hmac(:sha256, secret, data))
    |> String.downcase
    |> Plug.Crypto.secure_compare(hmac) do
      conn
    else
      conn
      |> put_status(401)
      |> Phoenix.Controller.text("")
      |> halt
    end
  end

  defp separate_query_hmac(conn) do
    {hmac, map} = conn.query_params |> Map.pop("hmac")
    {hmac, map |> URI.encode_query}
  end
end
