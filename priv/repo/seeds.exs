# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     P.Repo.insert!(%P.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias P.Data.File, as: DataFile

DataFile.list_card_series()
|> Enum.each(fn series ->
  DataFile.list_cards_in_series(series)
  |> Enum.each(fn id ->
    case DataFile.read_card(series, id) do
      {:ok, card} -> DataFile.to_card_changeset(card) |> IO.inspect() |> P.Repo.insert!()
      _ -> IO.puts("Card not found: #{series} #{id}")
    end
  end)
end)
