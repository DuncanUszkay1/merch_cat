defmodule MerchCat.Repo.Migrations.CreateShops do
  use Ecto.Migration

  def change do
    create table(:shops) do
      add :shopify_domain, :string
      add :shopify_token, :string

      timestamps()
    end

    create unique_index(:shops, [:shopify_domain])
    create unique_index(:shops, [:shopify_token])
  end
end
