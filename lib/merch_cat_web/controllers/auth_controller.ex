defmodule MerchCatWeb.AuthController do
  use MerchCatWeb, :controller

  alias MerchCat.ShopifyApp
  alias MerchCat.ShopifyApp.Shop

  def shopify(conn, %{"shop" => shopify_domain, "code" => shopify_token}) do
    session = shopify_domain |> Shopify.session()

    with {:ok, %{data: oauth}} <- Shopify.OAuth.request_token(session, shopify_token),
         {:ok, shop} <-
           ShopifyApp.create_or_update_shop(%{
             shopify_domain: shopify_domain,
             shopify_token: oauth.access_token
           }) do
      conn
      |> put_flash(:info, "Shop created successfully.")
      |> redirect(to: Routes.shop_path(conn, :show, shop))
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        redirect(conn, to: Routes.shop_path(conn, :new, changeset))

      {:error, _other} ->
        redirect(conn, to: Routes.shop_path(conn, :new))
    end
  end
end
