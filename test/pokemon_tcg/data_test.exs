defmodule P.DataTest do
  use P.DataCase

  alias P.Data

  describe "cards" do
    alias P.Data.Card

    import P.DataFixtures

    @invalid_attrs %{data: nil, name: nil, number: nil, types: nil, supertype: nil, subtypes: nil, evolves_to: nil, evolves_from: nil}

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Data.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Data.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      valid_attrs = %{data: %{}, name: "some name", number: "some number", types: ["option1", "option2"], supertype: "some supertype", subtypes: ["option1", "option2"], evolves_to: "some evolves_to", evolves_from: "some evolves_from"}

      assert {:ok, %Card{} = card} = Data.create_card(valid_attrs)
      assert card.data == %{}
      assert card.name == "some name"
      assert card.number == "some number"
      assert card.types == ["option1", "option2"]
      assert card.supertype == "some supertype"
      assert card.subtypes == ["option1", "option2"]
      assert card.evolves_to == "some evolves_to"
      assert card.evolves_from == "some evolves_from"
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      update_attrs = %{data: %{}, name: "some updated name", number: "some updated number", types: ["option1"], supertype: "some updated supertype", subtypes: ["option1"], evolves_to: "some updated evolves_to", evolves_from: "some updated evolves_from"}

      assert {:ok, %Card{} = card} = Data.update_card(card, update_attrs)
      assert card.data == %{}
      assert card.name == "some updated name"
      assert card.number == "some updated number"
      assert card.types == ["option1"]
      assert card.supertype == "some updated supertype"
      assert card.subtypes == ["option1"]
      assert card.evolves_to == "some updated evolves_to"
      assert card.evolves_from == "some updated evolves_from"
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_card(card, @invalid_attrs)
      assert card == Data.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Data.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Data.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Data.change_card(card)
    end
  end
end
