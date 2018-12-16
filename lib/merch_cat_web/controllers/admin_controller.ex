defmodule MerchCatWeb.AdminController do
  use MerchCatWeb, :controller

  alias Nostrum.Api

  def discord_ping(conn, _params) do
    fetch_query_params(conn)

    message = "ping"
    channel = System.get_env("DISCORD_DEFAULT_CHANNEL")

    Api.create_message(String.to_integer(channel), message)

    send_resp(conn, 200, "")
  end
end
