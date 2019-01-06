defmodule MerchCat.ShopifyApp do
  @moduledoc """
  The ShopifyApp context.
  """

  import Ecto.Query, warn: false
  alias MerchCat.Repo

  alias MerchCat.ShopifyApp.Shop

  @doc """
  Returns the list of shops.

  ## Examples

      iex> list_shops()
      [%Shop{}, ...]

  """
  def list_shops do
    Repo.all(Shop)
  end

  @doc """
  Gets a single shop.

  Raises `Ecto.NoResultsError` if the Shop does not exist.

  ## Examples

      iex> get_shop!(123)
      %Shop{}

      iex> get_shop!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shop!(id), do: Repo.get!(Shop, id)

  @doc """
  Gets a single shop by selector.

  ## Examples

      iex> get_shop_by(:shopify_domain, "https://a-shopify-domain.com")
      %Shop{}

  """
  def get_shop_by(selector, value) do
    Repo.get_by!(Shop, %{selector => value})
  end

  @doc """
  Creates a shop.

  ## Examples

      iex> create_shop(%{field: value})
      {:ok, %Shop{}}

      iex> create_shop(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shop(attrs \\ %{}) do
    %Shop{}
    |> Shop.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shop.

  ## Examples

      iex> update_shop(shop, %{field: new_value})
      {:ok, %Shop{}}

      iex> update_shop(shop, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shop(%Shop{} = shop, attrs) do
    shop
    |> Shop.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Shop.

  ## Examples

      iex> delete_shop(shop)
      {:ok, %Shop{}}

      iex> delete_shop(shop)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shop(%Shop{} = shop) do
    Repo.delete(shop)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shop changes.

  ## Examples

      iex> change_shop(shop)
      %Ecto.Changeset{source: %Shop{}}

  """
  def change_shop(%Shop{} = shop) do
    Shop.changeset(shop, %{})
  end

  @doc """
  Creates a new shop if no shop with the given shopify_domain exists, or updates
  the existing shop
  ## Examples
    iex> create_or_update_shop(%{shopify_domain: "shop@my_shopify.com", shopify_token: "a-token"})
    {:ok, %Shop{}}
    iex> create_or_update_shop(%{shopify_domain: nil, shopify_token: "a-token"})
    {:error, %Ecto.Changeset{}}
  """
  def create_or_update_shop(%{shopify_domain: shopify_domain, shopify_token: _} = args) do
    case Repo.get_by(Shop, shopify_domain: args[:shopify_domain]) do
      nil -> create_shop(args)
      shop -> update_shop(shop,args)
    end
  end

  def create_or_update_shop(args) do
    create_shop(args)
  end
end
