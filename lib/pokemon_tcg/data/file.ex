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
    |> Map.put(:data, data)

    Card.changeset(%Card{}, data)
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
