defmodule Korigatachi.Repo do
  use Ecto.Repo,
    otp_app: :korigatachi,
    adapter: Ecto.Adapters.Postgres
end
