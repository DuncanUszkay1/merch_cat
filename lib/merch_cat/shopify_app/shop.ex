defmodule MerchCat.ShopifyApp.Shop do
  use Ecto.Schema
  import Ecto.Changeset


  schema "shops" do
    field :shopify_domain, :string
    field :shopify_token, :string

    timestamps()
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, [:shopify_domain, :shopify_token])
    |> validate_required([:shopify_domain, :shopify_token])
    |> unique_constraint(:shopify_domain)
    |> unique_constraint(:shopify_token)
  end
end
