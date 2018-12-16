defmodule MerchCatWeb.PageController do
  use MerchCatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
