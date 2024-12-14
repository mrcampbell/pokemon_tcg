defmodule P.Data.File do

  @src_dir "card_files"

  def get_card(id), do: read_file("#{@src_dir}/cards/en/#{id}.json")
  def get_deck(id), do: read_file("#{@src_dir}/decks/en/#{id}.json")
  def get_sets(), do: read_file("#{@src_dir}/sets/en.json")


  defp read_file(path) do
    case File.read(path) do
      {:ok, json} ->
        {:ok, Jason.decode!(json)}
      {:error, _} ->
        {:error, :not_found}
    end
  end
end
