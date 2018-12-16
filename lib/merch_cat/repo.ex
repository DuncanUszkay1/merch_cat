defmodule MerchCat.Repo do
  use Ecto.Repo,
    otp_app: :merch_cat,
    adapter: Ecto.Adapters.Postgres
end
