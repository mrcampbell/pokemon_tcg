defmodule P.Data.Card.Attack do
  use Ecto.Schema
  import Ecto.Changeset

  alias P.Data.Card

  embedded_schema do
    field :name, :string
    field :cost, {:array, Ecto.Enum}, values: Card.types()
    field :converted_energy_cost, :integer
    field :damage, :string
    field :text, :string
  end

  @doc false
  def changeset(attack, attrs) do
    attack
    |> cast(attrs, [:name, :cost, :converted_energy_cost, :damage, :text])
    |> validate_required([:name, :cost, :converted_energy_cost])
  end
end
