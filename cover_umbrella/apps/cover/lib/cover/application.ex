defmodule Cover.Application do
  @moduledoc """
  The Cover Application Service.

  The cover system business domain lives in this application.

  Exposes API to clients such as the `CoverWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Cover.Repo, []),
    ], strategy: :one_for_one, name: Cover.Supervisor)
  end
end
