defmodule P.Data.File do
  alias P.Data.Card

  @src_dir "card_files"

  def get_card_series(id), do: read_file("#{@src_dir}/cards/en/#{id}.json")
  def get_deck_series(id), do: read_file("#{@src_dir}/decks/en/#{id}.json")
  def get_sets(), do: read_file("#{@src_dir}/sets/en.json")

  @spec to_card(map) :: Card.t()
  def to_card(data) do
    data = %{}
    |> Map.put(:id, data["id"])
    |> Map.put(:number, data["number"])
    |> Map.put(:name, data["name"])
    |> Map.put(:supertype, data["supertype"])
    |> Map.put(:subtypes, data["subtypes"])
    |> Map.put(:types, data["types"])
    |> Map.put(:evolves_to, data["evolvesTo"])
    |> Map.put(:evolves_from, data["evolvesFrom"])
    |> Map.put(:data, to_data_schema(data))

    Card.changeset(%Card{}, data)
  end

  def to_data_schema(data) do
    IO.inspect(data)
    %{}
    |> Map.put(:level, data["level"])
    |> Map.put(:hp, data["hp"])
    |> Map.put(:attacks, to_attacks(data["attacks"]))
    |> Map.put(:weaknesses, data["weaknesses"])
    |> Map.put(:retreat_cost, data["retreatCost"])
    |> Map.put(:converted_retreat_cost, data["convertedRetreatCost"])
    |> Map.put(:artist, data["artist"])
    |> Map.put(:rarity, data["rarity"])
    |> Map.put(:flavor_text, data["flavorText"])
    |> Map.put(:national_pokedex_numbers, data["nationalPokedexNumbers"])
    |> Map.put(:legalities, data["legalities"])
  end

  def to_attacks(nil), do: []
  def to_attacks(data) do
    data
    |> Enum.map(&to_attack/1)
  end

  def to_attack(data) do
    %{}
    |> Map.put(:cost, data["cost"])
    |> Map.put(:name, data["name"])
    |> Map.put(:text, data["text"])
    |> Map.put(:damage, data["damage"])
    |> Map.put(:converted_energy_cost, data["convertedEnergyCost"])
  end

  def to_weakness(data) do
    %{}
    |> Map.put(:type, data["type"])
    |> Map.put(:value, data["value"])
  end

  defp read_file(path) do
    case File.read(path) do
      {:ok, json} ->
        {:ok, Jason.decode!(json)}
      {:error, _} ->
        {:error, :not_found}
    end
  end
end
