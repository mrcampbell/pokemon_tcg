defmodule P.Data.Card.Resistance do
  use Ecto.Schema
  import Ecto.Changeset
  alias P.Data.Card

  embedded_schema do
    field :type, Ecto.Enum, values: Card.types()
    field :value, :string
  end

  @doc false
  def changeset(resistance, attrs) do
    resistance
    |> cast(attrs, [:type, :value])
    |> validate_required([:type, :value])
  end
end
