defmodule P.Data.Card.Weakness do
  use Ecto.Schema
  import Ecto.Changeset
  alias P.Data.Card

  @primary_key false
  embedded_schema do
    field :type, Ecto.Enum, values: Card.types()
    field :value, :string
  end

  @doc false
  def changeset(weakness, attrs) do
    weakness
    |> cast(attrs, [:type, :value])
    |> validate_required([:type, :value])
  end
end
