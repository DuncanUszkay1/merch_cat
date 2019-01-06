defmodule MerchCatWeb.Shopify.AdvertiseController do
  use MerchCatWeb, :controller

  alias MerchCat.ShopifyApp
  alias MerchCat.ShopifyApp.Shop
  alias Nostrum.Api

  require Logger

  def discord(conn, args) do
    channel = System.get_env("DISCORD_DEFAULT_CHANNEL")

    shopify_bag = "https://www.nchannel.com/wp-content/uploads/2014/11/Order-Printer-Shopify-App.jpg"
    shopify_domain = args["shop"]
    stock = "10"
    title = "example title"
    handle = "example-handle"

    import Nostrum.Struct.Embed
    embed =
      %Nostrum.Struct.Embed{}
      |> put_title("Buy Now")
      |> put_field("Stock remaining:", stock, true)
      |> put_author(args["title"], "https://www.google.com", shopify_bag)
      |> put_footer("Footer Text", shopify_bag)
      |> put_image("https://images.paom.com/epaomfp/print_all_over_me_3_t-shirt_0000000p-imaqtpie.png?format=webp&height=800")
      |> put_url("https://" <> shopify_domain <> "/products/" <> handle)

    Api.create_message!(String.to_integer(channel), embed: embed)

    send_resp(conn, 200, "")
  end
end
