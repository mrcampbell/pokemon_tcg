defmodule P.DataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `P.Data` context.
  """

  @doc """
  Generate a card.
  """
  def card_fixture(attrs \\ %{}) do
    {:ok, card} =
      attrs
      |> Enum.into(%{
        data: %{},
        evolves_from: "some evolves_from",
        evolves_to: "some evolves_to",
        name: "some name",
        number: "some number",
        subtypes: ["option1", "option2"],
        supertype: "some supertype",
        types: ["option1", "option2"]
      })
      |> P.Data.create_card()

    card
  end
end
