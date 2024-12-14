defmodule P.Repo do
  use Ecto.Repo,
    otp_app: :pokemon_tcg,
    adapter: Ecto.Adapters.Postgres
end
