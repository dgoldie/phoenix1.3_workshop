# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DevApp.Repo.insert!(%DevApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias DevApp.Accounts

#### Users
#
Accounts.delete_all_users
IO.puts "deleted all Users. count = #{Accounts.count_users}."

user_names = ~w(Doug Kat Joe Andy)
number_of_pets = [45, 10, 100, 55]

for {name, num} <- Enum.zip(user_names, number_of_pets) do
  Accounts.create_user %{name:  name, bio: "#{name} loves Elixir!",
                         email: "#{name}@dev.com", number_of_pets: num}
end

IO.puts "create #{Accounts.count_users} Users."
