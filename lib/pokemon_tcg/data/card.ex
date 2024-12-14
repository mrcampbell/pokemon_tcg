defmodule P.Data.Card do
  alias P.Data.Card.Data
  use Ecto.Schema
  import Ecto.Changeset

  @types ["Colorless": 0, "Darkness": 1, "Dragon": 2, "Fairy": 3, "Fighting": 4, "Fire": 5, "Grass": 6, "Lightning": 7, "Metal": 8, "Psychic": 9, "Water": 10]
  @subtypes ["Supporter": 0, "Pokémon Tool": 1, "Item": 2, "Stadium": 3, "Basic": 4, "Stage 1": 5, "Stage 2": 6, "GX": 7, "EX": 8, "Mega": 9, "BREAK": 10, "V": 11, "VMAX": 12]
  @supertypes ["Pokémon": 0, "Trainer": 1, "Energy": 2]

  @primary_key {:id, :string, autogenerate: false}
  @foreign_key_type :binary_id
  schema "cards" do
    embeds_one :data, Data
    field :name, :string
    field :number, :string
    field :types, {:array, Ecto.Enum}, values: @types
    field :supertype, Ecto.Enum, values: @supertypes
    field :subtypes, {:array, Ecto.Enum}, values: @subtypes
    field :evolves_to, {:array, :string}
    field :evolves_from, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:id, :name, :supertype, :subtypes, :types, :evolves_to, :evolves_from, :number])
    |> validate_required([:name, :supertype, :subtypes, :types, :number])
    |> cast_embed(:data, with: &Data.changeset/2)
  end

  def types(), do: @types
end
