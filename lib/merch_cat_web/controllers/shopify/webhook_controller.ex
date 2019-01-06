defmodule MerchCatWeb.Shopify.WebhookController do
  use MerchCatWeb, :controller

  alias MerchCat.ShopifyApp
  alias MerchCat.ShopifyApp.Shop
  alias Nostrum.Api

  require Logger

  def shopify(conn, args) do
    channel = System.get_env("DISCORD_DEFAULT_CHANNEL")

    shopify_bag = "https://www.nchannel.com/wp-content/uploads/2014/11/Order-Printer-Shopify-App.jpg"
    shop = conn.private[:shop]

    import Nostrum.Struct.Embed
    embed =
      %Nostrum.Struct.Embed{}
      |> put_title("Buy Now")
      |> put_field("Stock remaining:", "#{hd(args["variants"])["inventory_quantity"]}", true)
      |> put_author(args["title"], "https://www.google.com", shopify_bag)
      |> put_footer("Footer Text", shopify_bag)
      |> put_image("https://images.paom.com/epaomfp/print_all_over_me_3_t-shirt_0000000p-imaqtpie.png?format=webp&height=800")
      |> put_url("https://" <> shop.shopify_domain <> "/products/" <> args["handle"])

    Api.create_message!(String.to_integer(channel), embed: embed)

    send_resp(conn, 200, "")
  end
end
