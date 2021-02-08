defmodule FireWatch.Repo do
  use Ecto.Repo,
    otp_app: :fire_watch,
    adapter: Ecto.Adapters.Postgres
end
