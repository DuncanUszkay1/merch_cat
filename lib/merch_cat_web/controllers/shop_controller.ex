defmodule MerchCatWeb.ShopController do
  use MerchCatWeb, :controller

  alias MerchCat.ShopifyApp
  alias MerchCat.ShopifyApp.Shop

  def index(conn, _params) do
    shops = ShopifyApp.list_shops()
    render(conn, "index.html", shops: shops)
  end

  def new(conn, _params) do
    changeset = ShopifyApp.change_shop(%Shop{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"shop" => shop_params}) do
    case ShopifyApp.create_shop(shop_params) do
      {:ok, shop} ->
        conn
        |> put_flash(:info, "Shop created successfully.")
        |> redirect(to: Routes.shop_path(conn, :show, shop))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    shop = ShopifyApp.get_shop!(id)
    render(conn, "show.html", shop: shop)
  end

  def signup(conn, %{"shop" => %{"shopify_domain" => shop_name}}) when shop_name != "" and not is_nil(shop_name) do
    params = %{scope: "read_products", redirect_uri: "https://1e0905be.ngrok.io/auth"}
    permission_url = shop_name |> Shopify.session() |> Shopify.OAuth.permission_url(params)
    conn
    |> redirect(external: permission_url)
  end

  def signup(conn, _) do
    {:error, changeset} = ShopifyApp.create_shop(%{})
    render(conn, "new.html", changeset: changeset)
  end
#
#  def edit(conn, %{"id" => id}) do
#    shop = ShopifyApp.get_shop!(id)
#    changeset = ShopifyApp.change_shop(shop)
#    render(conn, "edit.html", shop: shop, changeset: changeset)
#  end
#
#  def update(conn, %{"id" => id, "shop" => shop_params}) do
#    shop = ShopifyApp.get_shop!(id)
#
#    case ShopifyApp.update_shop(shop, shop_params) do
#      {:ok, shop} ->
#        conn
#        |> put_flash(:info, "Shop updated successfully.")
#        |> redirect(to: Routes.shop_path(conn, :show, shop))
#
#      {:error, %Ecto.Changeset{} = changeset} ->
#        render(conn, "edit.html", shop: shop, changeset: changeset)
#    end
#  end
#
#  def delete(conn, %{"id" => id}) do
#    shop = ShopifyApp.get_shop!(id)
#    {:ok, _shop} = ShopifyApp.delete_shop(shop)
#
#    conn
#    |> put_flash(:info, "Shop deleted successfully.")
#    |> redirect(to: Routes.shop_path(conn, :index))
#  end
end
