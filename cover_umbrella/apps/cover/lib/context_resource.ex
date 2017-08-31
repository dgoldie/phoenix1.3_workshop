defmodule Cover.ContextResource do
  alias Cover.Repo

  defmacro __using__(options) do
    quote do
      IO.puts "In using's context (#{__MODULE__})."
      IO.puts "repo is #{ unquote(options)[:repo]}"
      @repo unquote(options)[:repo]

      import unquote(__MODULE__)
      import Ecto.Query, warn: false
    end
  end

  defmacro resources(table) do
    IO.puts "In macro's context (#{__MODULE__})."
    # IO.puts "table is #{ Macro.to_string table}"

    quote bind_quoted: [table: table] do
      IO.puts "In caller's context (#{__MODULE__})."
      # IO.puts "table is #{inspect table}"
      # IO.inspect apply(table, :__schema__, [:source])
      # IO.inspect Module.split table

      IO.inspect "repo here is #{@repo}"

      source = apply(table, :__schema__, [:source])
      # IO.puts "source is #{source}"
      single_source = table
                      |> Module.split
                      |> List.last
                      |> String.downcase
      # IO.puts "single source is #{single_source}"

      # list
      list_name = String.to_atom("list_#{source}")
      def unquote(list_name)() do
        @repo.all(unquote(table))
      end

      # get
      get_name = String.to_atom("get_#{single_source}")
      def unquote(get_name)(id) do
        @repo.get(unquote(table), id)
      end

      # get!
      get_name! = String.to_atom("get_#{single_source}!")
      def unquote(get_name!)(id) do
       @repo.get!(unquote(table), id)
      end

      #create
      create_name = String.to_atom("create_#{single_source}")
      def unquote(create_name)(attrs \\ %{}) do
        unquote(table).__struct__
        |> unquote(table).changeset(attrs)
        |> @repo.insert()
      end

      #update
      update_name = String.to_atom("update_#{single_source}")
      table_struct = table.__struct__
      def unquote(update_name)(table_struct = record, attrs) do
        record
        |> unquote(table).changeset(attrs)
        |> @repo.update()
      end

      # delete
      delete_name = String.to_atom("delete_#{single_source}")
      table_struct = table.__struct__
      def unquote(delete_name)(table_struct = record) do
        @repo.delete(record)
      end

      # change
      change_name = String.to_atom("change_#{single_source}")
      table_struct = table.__struct__
      def unquote(change_name)(table_struct = record) do
        unquote(table).changeset(record, %{})
      end


    end

  end

end
