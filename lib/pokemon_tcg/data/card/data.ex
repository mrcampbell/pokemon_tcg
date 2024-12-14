defmodule P.Data.Card.Data do
  use Ecto.Schema
  import Ecto.Changeset

  alias P.Data.Card
  alias P.Data.Card.Weakness
  alias P.Data.Card.Resistance
  alias P.Data.Card.Attack

  embedded_schema do
    field :level, :integer
    field :hp, :integer
    embeds_many :attacks, Attack
    embeds_many :weaknesses, Weakness
    embeds_many :resistances, Resistance
    field :retreat_cost, {:array, Ecto.Enum}, values: Card.types(), default: []
    field :converted_retreat_cost, :integer, default: 0
    field :artist, :string
    field :rarity, :string
    field :flavor_text, :string
    field :national_pokedex_numbers, {:array, :integer}
    field :legalities, :map
  end

  @doc false
  def changeset(content, attrs) do
    content
    |> cast(attrs, [:level, :hp, :retreat_cost, :converted_retreat_cost, :artist, :rarity, :flavor_text, :national_pokedex_numbers, :legalities])
    |> validate_required([:level, :hp, :artist, :rarity, :flavor_text, :national_pokedex_numbers, :legalities])
    |> cast_embed(:attacks, with: &Attack.changeset/2, required: false)
    |> cast_embed(:weaknesses, with: &Weakness.changeset/2, required: false)
    |> cast_embed(:resistances, with: &Resistance.changeset/2, required: false)
  end
end
