# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FireWatch.Repo.insert!(%FireWatch.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias FireWatch.Fires.CSV

CSV.import_fires("forestfires.csv")
|> CSV.convert_fires()
|> CSV.batch_insert()
