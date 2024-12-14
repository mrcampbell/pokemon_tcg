defmodule P.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :card_id, :string
      add :name, :string
      add :supertype, :string
      add :subtypes, {:array, :string}
      add :types, {:array, :string}
      add :evolves_to, {:array, :string}
      add :evolves_from, :string
      add :number, :string
      add :data, :map

      timestamps(type: :utc_datetime)
    end
  end
end
