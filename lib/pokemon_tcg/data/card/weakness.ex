defmodule P.Data.Card.Weakness do
  use Ecto.Schema
  import Ecto.Changeset
  alias P.Data.Card

  embedded_schema do
    field :type, Ecto.Enum, values: Card.types()
    field :value, Ecto.Enum, values: ["x2": 0] # not sure if there are others, but it's open ended
  end

  @doc false
  def changeset(weakness, attrs) do
    weakness
    |> cast(attrs, [:type, :value])
    |> validate_required([:type, :value])
  end
end
